# README

![https://images.unsplash.com/photo-1640622300930-6e8daa98536f?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb](https://images.unsplash.com/photo-1640622300930-6e8daa98536f?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb)

## Introduction

### Données


Notre jeu de données provient d’un sondage réalisé en 2014 sur des travailleurs du domaine de la technologie pour la plupart. Il concerne des questions liées aux attitudes à l'égard de la santé mentale dans le monde professionnel, ainsi que la fréquence des troubles de santé mentale dans ce milieu.

Les données viennent pour les trois quarts des États-Unis et du Royaume-Uni.
Le dataset est au format CSV. Nous l’avons récupéré via le site Kaggle (https://www.kaggle.com/osmi/mental-health-in-tech-survey)

Nous avons choisi ce dataset, car il s’intègre parfaitement dans le contexte de “l’après-Covid”. Ce dernier a engendré beaucoup de désordres psychologiques, notamment chez les salariés. Étudier un jeu de données de ce type nous a donc semblé très intéressant dans ce contexte.

Le jeu de données comprend 1259 réalisations (donc concerne un sondage réalisé sur 1259 individus). On compte également 27 variables, listées ci-dessous avec leur type.

| Nom de variable | Description | Type |
| --- | --- | --- |
| *Timestamp* | Date et heure auxquelles le sondage a été réalisé pour l'individu | Temporelle |
| *Age* | Age du répondant | Continue |
| *Gender* | Genre du répondant | Catégorielle |
| *Country* | Pays du répondant | Catégorielle |
| *state* | L'état où habite le répondant (s'il réside aux États-Unis) | Catégorielle |
| *self_employed* | Dit si le répondant est son propre patron ou non | Catégorielle binaire |
| *family_history* | Dit s'il y a des antécédents familiaux de maladies mentales | Catégorielle binaire |
| *treatment* | Dit si le répondant prend un traitement ou non pour cause de trouble de la santé mentale | Catégorielle binaire |
| *work_interfere* | Dit si un problème de santé mentale interfère ou non avec le travail | Ordinale |
| *no_employees* | Nombre d'employés dans l'entreprise du répondant | Continue |
| *remote_work* | Dit si le salarié travaille au moins 50% du temps à distance | Catégorielle binaire |
| *tech_company* |  Dit si l'entreprise est du domaine de la technologie| Catégorielle binaire |
| *benefits* | Dit si l'employeur propose des mesures en terme de santé mentale | Catégorielle |
| *care_options* | Dit si l'entreprise communique bien sur tout ce qui peut être mis en place pour la santé mentale de l'employé | Catégorielle |
| *wellness_program* | Dit si l'employeur a déjà abordé la question de la santé mentale dans le cadre d'un programme de bien-être au profit des salariés | Catégorielle |
| *seek_help* | Dit si l'employeur fournit des ressources pour en savoir plus sur les problèmes de santé mentale et sur la façon de demander de l'aide | Catégorielle |
| *anonymity* | Dit si l'anonymat du salarié est protégé s'il choisit de profiter des ressources de traitement de la santé mentale ou de la toxicomanie | Catégorielle |
| *leave* | Dit à quel point il est facile pour le salarié de prendre un congé pour un problème de santé mentale | Ordinale |
| *mental_health_consequence* | Dit si le salarié pense que discuter de problèmes de santé mentale aurait des conséquences négatives | Catégorielle |
| *phys_health_consequence* | Dit si le salarié pense que discuter de problèmes de santé physique aurait des conséquences négatives | Catégorielle |
| *coworkers* | Dit si le salarié discuterait de problèmes de santé mentale avec ses collègues | Catégorielle |
| *supervisor* | Dit si le salarié discuterait de problèmes de santé mentale avec son(es) supérieur(s) direct(s) | Catégorielle |
| *mental_health_interview* | Dit si un travailleur en recherche de travail aborderait le sujet de problèmes de santé mentale avec un potentiel employeur | Catégorielle |
| *phys_health_interview* | Dit si un travailleur en recherche de travail aborderait le sujet de problèmes de santé physique avec un potentiel employeur | Catégorielle |
| *mental_vs_physical* | Dit si le travailleur pense que son employeur prend les problèmes de santé mentale aussi sérieusement que des problèmes de santé physique  | Catégorielle |
| *obs_consequence* | Dit si le salarié a déjà connu des cas (dans ses collègues notamment) où des problèmes de santé mentale aurait eu de mauvaises conséquences  | Catégorielle |
| *comments* | Commentaires supplémentaires ajoutés par l'individu |


### Plan d'analyse


Tout au long de cette étude, nous allons chercher à répondre aux problématiques suivantes :

<center>

**Peut-on extraire un profil type du travailleur souffrant de troubles psychologiques ou de santé mentale impactant son travail ?** 

**Peut-on extraire un profil type d’entreprise qui regroupe les salariés les plus impactés par des troubles psychologiques ou de santé mentale au travail ? Un profil type selon la géographie ?**

**Quels sont les prédicteurs les plus fiables des troubles de la santé mentale dans le monde du travail ?**
</center>


Nous allons tenter de répondre à ces questionnements via les analyses suivantes :


| Questions | Variables associées |
| --- | --- |
| Y a-t-il une corrélation entre la santé mentale d’un salarié et le lieu géographique où il travaille ? | *Country, state, work_interfere* |
| Existe-t-il un lien entre l'impact des problèmes psychologiques et l'âge/le sexe ? | *work_interfere, Age* |
| Y a-t-il une corrélation entre le type d’entreprise où la personne travaille (patron ou non, domaine, nombre d’employés…) et la santé mentale du travailleur? | *self_employed, work_interfere, no_employees, remote_work, tech_company* |
| Y a-t-il une corrélation entre la facilité de prendre un congé pour cause de désordre mentale dans l’entreprise et le fait ou non que les employeurs aient mis en place des mesures pour la santé mentale? | *work_interfere, anonymity, leave* |
| Y a-t-il une corrélation entre l’ouverture d’esprit de l’entreprise et les mesures qu’elle peut mettre en place pour la santé mentale de ses salariés, et le fait que la santé mentale interfère avec le travail ? | *work_interfere, benefits, care_option, wellness_program, seek_help, anonymity, leave, mental_health_consequence, supervisor, obs_consequence* |
| Y a-t-il une corrélation entre l’attitude de son employeur et celle de ses collègues sur le sujet de la santé mentale? | *mental_health_consequence, coworkers, supervisor* |
| Y a-t-il une corrélation entre le fait qu’un salarié en recherche de travail va aborder le sujet de la santé mentale avec un potentiel employeur, et le fait qu’il ait déjà connu/assisté à des conséquences négatives que cela a eu ? | *mental_health_interview, obs_consequence* |
| Y a-t-il une corrélation entre santé mentale et travail à distance ? | *work_interfere, remote_work* |
| Les employés sont plus susceptibles d'aborder les problèmes de santé mentale avec leurs collègues qu'avec leurs employeurs ? | *mental_health_consequence, coworkers, supervisor* |



Nous rencontrerons les problèmes suivants :


- Au niveau de la forme des données : en effet, on voit par exemple que la variable “*gender*” contient à la fois des valeurs “*male*” mais aussi des valeurs “*Males*”. La non uniformité des valeurs compliquera éventuellement quelque peu la tâche.


- La dernière donnée “*comments*” qui sera plus difficile à exploiter de par sa forme, mais qui peut néanmoins contenir des informations intéressantes.


- D’autre part, il est à noter une grande homogénéité des pays concernés par le sondage (60% aux USA, 15% au Royaume-Uni). Notre analyse ne sera donc pas forcément représentative pour les autres pays, qui sont sous-représentés dans ce dataset.
