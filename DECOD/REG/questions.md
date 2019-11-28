Liste des questions à poser à J-L (écrites depuis le terminal bien évidemment)

Si t'as des réponses je suis preneur !

2 ports d'invalidation car une instruction peut produire 2 résultats ?????
-> Cas ou EXEX et MEM écrivent en meme temps ???

------
Par exemple une instruction de type LB qui va écrit sur RD, et/puis fait une post/pre incrémentation sur la deuxième opérandeLe prof dit : "mem et exec peuvent produire simultanément un résultat, en cas de conflit (même registre de destination), l’écriture provenant de mem doit être ignorée car nécessairement plus ancienne." donc moi je comprends qu'il n'y a conflit et nécesssité de choisir que si c'est le MEME REGISTRE sur les deux WRITE.
------


(1) Doit-on assigner la valeur des signaux out dans le process ou en dehors ? Car si on assigne dans le process, les signaux ne seront à jours qu'au prochain front montant, donc retard mais toujours au meme moment. Si on assigne les signaux en dehors du proc, ils seront directement assignés (on pet donc considérer sur le front montant meme).
Donc Yannis a raison, normalement. Les 2 versions marchent mais celles avec les signaux out assignés dans le process sera plus lente (delay d'un cycle d'horloge).

--------
On a notre réponse grâce a la simulation, si tu as le choix, il est préférable d'assigner un signal sur une sortie en dehors du process
--------

(2)	Quand inc_pc = '1', doit on aussi vérifier que son bit d'invalidité l'est aussi avant d'incrémenter PC ? Après avoir écrit PC + 4, on doit remettre inval(15) = '0' , donc valide ?

--------
Ouais, pour moi, on le gère pareil dans le sens ou si on veut écrire dessus, on met son bit d'invalidité pour qu'il n'y ai pas de lecture entre temps.
--------

En MIPS, le PC pointe sur le 1er byte de l'instruction, donc +4 bytes pour aller à l'instruction suivante. Pour ARM, le PC est 2 instructions en avance (8 bytes) due au prefetch effectué par le proc. 
-> L'addresse de l'instruction exécutée est donc PC-8
--------
Peut-être, je comprends pas bien les répercussion de ça, mais le prof dit bien de faire +4
--------

(3) MEM moins prioritaire que EXEC s'ils sont executés simultanément, ca veut dire que EXEC c'est wdata1 et MEM wdata2 ? (en cas d'écriture simultanée). Les 2 pourront écrire si les wdata ne correspondent pas. (a ajouter dans le code).

--------
Pour moi, ça veut dire que il faut décider qu'un des deux sera plus prioritraire, donc le 1 par exemple. On IGNOERERA la demande d'écriture venant de MEM si c'est le MEME registre de destination, sinon on le fera.
--------

(4) L'étage DECOD enverra t-il tout le temps 3 ports de lecture en entrée de REG ? Seulement 1 est nécessaire si OP2 est un immédiat.

--------
Pour moi, c'est le role de decode de décoder, donc de savoir combien il faut d'opérande, donc si il en a besoin que d'une, il ne demande qu'une. (ma première idée est une sorte de multiplexeur, qui envoi ou non la demande pour rs, rt, rm au banc de registre.
--------
 
(5) Question très con -> Rd forcément un registre d'écriture ?ù

--------
Du coup tu me mets le doute, mais pour moi le "d" veut dire destination, donc oui, ça permet dans DECODE, selon mon idée, de pacer Rd dans la fifo pour exec directement.
--------

 Pour résumer le banc de registre, il sert a envoyer les valeurs contenues dans les registres, tout en vérifiant si le registre est invalide (en cas d'écriture), et à incrémenter la valeur de PC (car c'est une registre). Il s'occupera également d'update les flags. 
 
--------
ouais je suis d'accord. Autrement dit, il s'assure que les registre sont bien lu et écrit au bon moment.
--------
