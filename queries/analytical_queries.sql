--le nombre total de produits et le prix moyen global
select
    count(*) as total_produits,
    round(avg(prix), 2) as prix_moyen_global,
    min(prix) as prix_min,
    max(prix) as prix_max
from (
    select nom, prix from bagues
    union all
    select nom, prix from bracelets
    union all
    select nom, prix from boucles_oreilles
    union all
    select nom, prix from colliers
    union all
    select nom, prix from parures
) as all_produits;
--le taux de disponibilité par catégorie
elect
    'Bagues' as categorie, count(*) as produits_total, sum(1) as produits_en_stock
from bagues
union all
select 'Bracelets', count(*), sum(1) from bracelets
union all
select 'Boucles d''oreilles', count(*), sum(1) from boucles_oreilles
union all
select 'Colliers', count(*), sum(1) from colliers
union all
select 'Parures', count(*), sum(1) from parures;
--Produits premium par catégorie (top 25%)
select *
from (
    select
        nom,
        categorie,
        prix,
        percentile_cont(0.75) over (partition by categorie order by prix) as percentile_75
    from (
        select nom, categorie, prix from bagues
        union all
        select nom, categorie, prix from bracelets
        union all
        select nom, categorie, prix from boucles_oreilles
        union all
        select nom, categorie, prix from colliers
        union all
        select nom, categorie, prix from parures
    ) as all_produits
) t
where prix >= percentile_75;

--identifier les collections les plus variées ou riches en symboles.
select
    collection,
    count(distinct coalesce(symbole,'non_renseigné')) as nb_symboles
from (
    select collection, symbole from bagues
    union all
    select collection, symbole from bracelets
    union all
    select collection, symbole from boucles_oreilles
    union all
    select collection, symbole from colliers
    union all
    select collection, symbole from parures
) t
group by collection
order by nb_symboles desc;

--connaître rapidement le taux de disponibilité par collection ( en utilisant une vue ):
create or replace view v_stock_collection as
select
    collection,
    count(*) as total_produits,
    sum(case when en_stock then 1 else 0 end) as produits_en_stock,
    100.0 * sum(case when en_stock then 1 else 0 end)/count(*) as taux_disponibilite
from v_produits_analyse
group by collection;

--Produits avec prix supérieur à la moyenne de leur catégorie(j'ai utilise CTE)
with moyenne_categorie as (
    select categorie, avg(prix) as prix_moyen
    from v_produits_analyse
    group by categorie
)
select p.nom, p.categorie, p.prix, m.prix_moyen
from v_produits_analyse p
join moyenne_categorie m
    on p.categorie = m.categorie
where p.prix > m.prix_moyen;
--créer une table pivot des produits par collection et segment de prix ( cross table ) + ( extension ):
-- Active l'extension
create extension if not exists tablefunc;

select *
from crosstab(
    'select collection,
            case
                when prix < 50 then ''entrée''
                when prix between 50 and 100 then ''milieu''
                else ''haut''
            end as segment_prix,
            count(*) 
     from v_produits_analyse
     group by collection, segment_prix
     order by 1,2',
    'values (''entrée''), (''milieu''), (''haut'')'
) as ct(collection text, entree int, milieu int, haut int);

