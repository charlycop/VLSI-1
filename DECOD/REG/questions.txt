Liste des questions à poser à J-L (écrites depuis le terminal bien évidemment)

Si t'as des réponses je suis preneur !

2 ports d'invalidation car une instruction peut produire 2 résultats ?????
-> Cas ou EXEX et MEM écrivent en meme temps ???


(1) Doit-on assigner la valeur des signaux out dans le process ou en dehors ? Car si on assigne dans le process, les signaux ne seront à jours qu'au prochain front montant, donc retard mais toujours au meme moment. Si on assigne les signaux en dehors du proc, ils seront directement assignés (on pet donc considérer sur le front montant meme).
Donc Yannis a raison, normalement. Les 2 versions marchent mais celles avec les signaux out assignés dans le process sera plus lente (delay d'un cycle d'horloge).

(2)	Quand inc_pc = '1', doit on aussi vérifier que son bit d'invalidité l'est aussi avant d'incrémenter PC ? Après avoir écrit PC + 4, on doit remettre inval(15) = '0' , donc valide ?

En MIPS, le PC pointe sur le 1er byte de l'instruction, donc +4 bytes pour aller à l'instruction suivante. Pour ARM, le PC est 2 instructions en avance (8 bytes) due au prefetch effectué par le proc. 
-> L'addresse de l'instruction exécutée est donc PC-8


(3) MEM moins prioritaire que EXEC s'ils sont executés simultanément, ca veut dire que EXEC c'est wdata1 et MEM wdata2 ? (en cas d'écriture simultanée). Les 2 pourront écrire si les wdata ne correspondent pas. (a ajouter dans le code).

(4) L'étage DECOD enverra t-il tout le temps 3 ports de lecture en entrée de REG ? Seulement 1 est nécessaire si OP2 est un immédiat.
 
(5) Question très con -> Rd forcément un registre d'écriture ?ù
 

 Pour résumer le banc de registre, il sert a envoyer les valeurs contenues dans les registres, tout en vérifiant si le registre est invalide (en cas d'écriture), et à incrémenter la valeur de PC (car c'est une registre). Il s'occupera également d'update les flags. 
