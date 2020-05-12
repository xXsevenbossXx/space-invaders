#lang scribble/manual

@title{Acting Shooting Star: Documentation}

@author["Olivier Nguyen" "Hicham Zghari" "Augustin Gauchet" "Imad Boudroua"]

@table-of-contents[]



@section{Actor}

@subsection{Structure}

@defstruct[actor ([position list?] [mailbox list?] [name any?] [category any?])]{
La structure qui décrit les acteurs.

@itemize[
 (item "position est une liste de deux éléments qui contient les coordonnées x et y")
 (item "mailbox est une liste de messages")
 (item "name? contient la représentation raart de l’acteur")
 (item "category est le type de l’acteur (joueur, ennemi, projectile)")]
}



message est une liste dont le contenu varie selon le type de message :
Pour les messages de mouvement “message” prend la forme (move ‘(position)) avec position le vecteur coordonnée qui va faire bouger l’acteur qui reçoit le message
Pour les messages de création d’acteur “message” prend la forme (create ‘(position)) avec position les coordonnées où est créé l’acteur

@subsection{Fonctions et prédicats}

@defproc[(name-of-actors [actor (actor?)])
			 
         name]{
  Retourne le nom de l'acteur
}

@defproc[(actor-location [actor (actor?)]) (listof number)]{
 retourne la liste de coordonnées de l'acteur}

@defproc[(actor-send [actor-send (actor?)] [message (message?)]) actor]{
 renvoie une copie de l’actor avec le message ajouté à sa mailbox}

@defproc[(x-pos-top-mail [actor actor?])
         entier]{
Si le message en première position de la mailbox de l’actor est un message de mouvement, renvoie la composante horizontale du mouvement en question
}

@defproc[(y-pos-top-mail [actor actor?])
             entier]{
Si le message en première position de la mailbox de l’actor est un message de mouvement, renvoie la composante verticale du mouvement en question
}


@defproc[(actor-update [actor actor?]) 
               (listof actor)]{
Retourne une liste dont le premier élément contenant à la fois une copie de l’acteur initial qui a effectué toutes les instructions contenues dans sa mailbox, et les actors créés par les messages de création.
}

@defproc[(colliding? [actor-1 actor?] [actor-2 actor?])
             boolean]{
Retourne @racket[#t] si les deux actors ont les mêmes coordonnées, @racket[#f] sinon
}

@defproc[(collisions? [actor actor?] [actors (listof actors?)])
              boolean]{
Retourne @racket[#t] s’il existe un actor dans la liste qui a les mêmes coordonnées que l’acteur passé en paramètre, @racket[#t] sinon
}

@section{World}

@subsection{Structure}

@defstruct[world ([actors (listof actors?)])]{
actors est la liste des acteurs intervenants dans le monde.}

@subsection{Fonctions et prédicats}

@defproc[(send-world [world world?] [message message?] [category any?]) world]{renvoie le monde dont chaque acteur de la catégorie spécifiée reçoit le nouveau message dans leur mailbox}
                                                                                   
@defproc[(update-world [world world?]) updated-world]{renvoie une copie du monde où tous les acteurs ont été mis à jour}

@defproc[(update-world [world world?]) void]{la liste contenant les derniers worlds est modifié par effet de bord, le monde est sauvegardé par ordre du plus récent au moins récent de gauche à droite. Si la taille du monde est égale à 20, le monde le plus ancien est effacé.}

@defproc[(world-travel [n number?] [current-world world?]) world?]{ le monde qui correspond au n-ième dernier monde parcouru. Si n >= 20 ou n < 0, on renvoie @racket[current-world].}

World Filter?

