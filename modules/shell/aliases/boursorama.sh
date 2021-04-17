function _qboursorama-match() {
  local line="$1"
  shopt -s nocasematch
  case $line in
    *categoryParent*)                   echo "$line;customCategory;customSubcategory;customDescription" ;; # header

    # weekly shopping
    *netto*)                            echo "$line;shopping;food;regular" ;;
    *u*express*)                        echo "$line;shopping;food;regular" ;;
    *monoprix*)                         echo "$line;shopping;food;regular" ;;
    *plaisir*des*ha*)                   echo "$line;shopping;food;regular" ;;
    *constans*et*fi*)                   echo "$line;shopping;food;panier-legumes" ;;
    *naturalia*)                        echo "$line;shopping;food;regular" ;;
    *carrefour*)                        echo "$line;shopping;food;regular" ;;
    *bioman*)                           echo "$line;shopping;food;bio" ;;
    *francis*viande*)                   echo "$line;shopping;food;x" ;;
    *livrais-expres*)                   echo "$line;shopping;food;livraison express carrefour" ;;
    *picard*surgeles*)                  echo "$line;shopping;food;compras picard" ;;
    *boucherie*de*la*tour*)             echo "$line;shopping;food;compras carne" ;;
    *le*neptune*)                       echo "$line;shopping;food;martatoexplain" ;;
    *biocoop*)                          echo "$line;shopping;food;bio" ;;
    *biobulle*)                         echo "$line;shopping;food;compras bio" ;;
    *quentin*poisso*)                   echo "$line;shopping;food;fish" ;;
    **bonta*italiane*)                  echo "$line;shopping;boulangerie;cosas italianas para comer" ;;
    *adegas*wine*)                      echo "$line;shopping;boulangerie;compras vinos" ;;
    *aurora*)                           echo "$line;shopping;boulangerie;panaderia" ;;
    *le*fournil*saint*francois*)        echo "$line;shopping;boulangerie;boulangerie" ;;
    *sc*armand*piet*)                   echo "$line;shopping;boulangerie;boulangerie" ;;
    *la*boulangerie*)                   echo "$line;shopping;boulangerie;boulangerie" ;;
    *paul*republique*)                  echo "$line;shopping;boulangerie;panaderia en av de la republique" ;;
    *l*artiste*pain*)                   echo "$line;shopping;boulangerie;panaderia" ;;
    *cep*boulanger*)                    echo "$line;shopping;boulangerie;panaderia" ;;
    *hoggar*viandes*)                   echo "$line;shopping;food;meat" ;;
    *lart*et*le*pain*)                  echo "$line;shopping;boulangerie;panaderia" ;;

    # maison
    *eurodif*)                          echo "$line;shopping;property;bazar" ;;
    *carre*blanc*)                      echo "$line;shopping;property;bazar" ;;
    *bricorama*)                        echo "$line;shopping;property;repair" ;;

    # baby
    *dr*de*paz*)                        echo "$line;baby;health;x" ;;
    *sergent*major*)                    echo "$line;baby;clothes;x" ;;
    *wedoogift*)                        echo "$line;baby;games;x" ;;
    *vente*privee*)                     echo "$line;baby;clothes;x" ;;
    *pinocchio*)                        echo "$line;baby;games;x" ;;
    *la*grande*recr*)                   echo "$line;baby;games;x" ;;
    *la*recree*)                        echo "$line;baby;games;x" ;;
    *barbe*de*papa*)                    echo "$line;baby;haircut;x" ;;
    *oeuvre*des*creches*de*nice*)       echo "$line;baby;creche;x" ;;
    *du*pareil*au*me*)                  echo "$line;baby;clothes;x" ;;
    *vertbaudet*)                       echo "$line;baby;clothes;x" ;;
    *decathlon*)                        echo "$line;baby;sport;decathlon" ;;
    *vinted*fr*)                        echo "$line;baby;clothes-stuff;vinted" ;;
    *mgp*vinted*)                       echo "$line;baby;clothes-stuff;vinted" ;;
    *sumup*saby*)                       echo "$line;baby;experience;manege-garibaldi" ;;

    # transport
    *escota*)                           echo "$line;leisure;transport;peages escota" ;;
    *station*avia*)                     echo "$line;leisure;transport;fuel avia" ;;
    *paybyphone*nic*)                   echo "$line;service;parking;auto parking mensual" ;;
    *agip*)                             echo "$line;service;transport;fuel agip" ;;
    *paypal*)                           echo "$line;service;paypal;netflix-spotify-etc" ;;

    # trip
    *volotea*)                          echo "$line;leisure;trip;plane" ;;
    *rla*automate*)                     echo "$line;leisure;transport;unknown" ;;

    # tech
    *amazon*)                           echo "$line;leisure;amazon;x" ;;
    *fnac*)                             echo "$line;leisure;fnac;x" ;;

    # sante
    *virto*fe*mar*)                     echo "$line;health;general;x" ;;
    *pharmacie*)                        echo "$line;health;pharmacie;x" ;;
    *gras*savoye*)                      echo "$line;health;mutuel;gras savoye" ;;
    *arpisante*)                        echo "$line;health;pharmacie;x" ;;

    # taxes
    *direction*generale*des*finance*)   echo "$line;tax;unknown;x" ;;
    *caf*alpes*)                        echo "$line;tax;caf;x" ;;
    *contravention*)                    echo "$line;tax;contravention;multas" ;;
    *forf*p*stat*web*)                  echo "$line;tax;contravention;multas" ;;

    # insurance
    *cpam*061*nice*)                    echo "$line;insurance;securite-social;securite-social" ;;
    *axa*)                              echo "$line;insurance;assurance voiture;x" ;;
    *crcam*provence*)                   echo "$line;insurance;assurance habitation;x" ;;

    # property
    *vir*sepa*le*domino*)               echo "$line;property;charges;x" ;;
    *vir*p1appeldesfonds*)              echo "$line;property;charges;x" ;;

    # service
    *edf*)                              echo "$line;service;edf;electricity" ;;
    *google*)                           echo "$line;service;googledrive;nas" ;;
    *vir*p1*internet*tv*)               echo "$line;service;tvinternet;x" ;;
    *la*poste*)                         echo "$line;service;laposte;x" ;;
    *orange*)                           echo "$line;service;internet;orange" ;;

    # vetement
    *hetm234*)                          echo "$line;basic;clothes;x" ;;
    *vp.com*)                           echo "$line;basic;clothes;x" ;;

    # marta unknown
    *selvi*didier*)                     echo "$line;leisure;unclear;martatoexplain" ;;
    *jm*et*mf*)                         echo "$line;leisure;unclear;martatoexplain" ;;
    *zara*home*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *adav*)                             echo "$line;leisure;unclear;martatoexplain" ;;
    *ouest*harmonie*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *cdiscount*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *tribeca*)                          echo "$line;leisure;unclear;martatoexplain" ;;
    *veze*contac*)                      echo "$line;leisure;unclear;martatoexplain" ;;
    *louise*le*club*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *paul*)                             echo "$line;leisure;unclear;martatoexplain" ;;
    *giorgeschi*)                       echo "$line;leisure;unclear;martatoexplain" ;;
    *sc*aurora*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *alice*delice*)                     echo "$line;leisure;unclear;martatoexplain" ;;
    *vival*sc*)                         echo "$line;leisure;unclear;martatoexplain" ;;
    *ek*saleya*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *l*agrume*)                         echo "$line;leisure;unclear;martatoexplain" ;;
    *ets*caranta*)                      echo "$line;leisure;unclear;martatoexplain" ;;
    *sc*goodfood*)                      echo "$line;leisure;unclear;martatoexplain" ;;
    *pastry*plaisir*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *pianelli*freres*)                  echo "$line;leisure;unclear;martatoexplain-crepes" ;;
    *peisino*)                          echo "$line;leisure;flowers;avoid" ;;
    *rodi*fleurs*)                      echo "$line;leisure;unclear;martatoexplain-flowers" ;;
    *au*bouquet*de*n*)                  echo "$line;leisure;unclear;martatoexplain-flowers" ;;
    *sc*a*la*mic*)                      echo "$line;leisure;unclear;martatoexplain-smth" ;;
    *armee*alpes*)                      echo "$line;leisure;unclear;mauritoexplain" ;;

    # feeding operations
    *fairness*)                         echo "$line;internal;feeding;seems fairness move mauri" ;;
    *vir*sepa*ranieri*730*)             echo "$line;internal;feeding;seems fairness move marta" ;;
    *salaire*fix*)                      echo "$line;internal;feeding;seems fairness move martax" ;;

    # internal bank operations / transfers
    *sepa*ranieri*marta*virements*re*)  echo "$line;internal;safe;safe move" ;;
    *safe*)                             echo "$line;internal;safe;safe move" ;;
    *sos*)                              echo "$line;internal;safe;safe move" ;;
    *interets*debiteurs*)               echo "$line;internal;service;boursorama" ;;
    *Mouvements*internes*)              echo "$line;internal;safe;safe" ;;
    *vir*interne*)                      echo "$line;internal;virement interne;x" ;;
    *virements*re*)                     echo "$line;internal;virement recu;x" ;;

    ## leisure
    # food
    *atelierrosemoo*)                   echo "$line;leisure;unclear;calendarios" ;;
    *leonidas*)                         echo "$line;leisure;boulangerie;boulangerie chic" ;;
    *jeff*de*bruges*)                   echo "$line;leisure;boulangerie;marta chocolates chic" ;;
    *canet*maccaran*)                   echo "$line;leisure;boulangerie;boulangerie chic" ;;
    *lac*barla*)                        echo "$line;leisure;boulangerie;boulangerie chic" ;;
    *lekobe*)                           echo "$line;leisure;luxury;sushi" ;;
    *vialatina*)                        echo "$line;leisure;boulangerie;cafe" ;;
    *patisserie*)                       echo "$line;leisure;unclear;patiseria" ;;
    *burlet*location*de*skis*)          echo "$line;leisure;ski;ski" ;;
    *tiger*)                            echo "$line;leisure;unclear;tiger" ;;
    *delices*de*la*republique*)         echo "$line;leisure;unclear;patiseria" ;;
    *pane*e*olio*)                      echo "$line;leisure;restaurant;coulee verte" ;;
    *sushi*)                            echo "$line;leisure;restaurant;sushi" ;;
    *the*healer*)                       echo "$line;leisure;restaurant;fast-food" ;;
    # food delivery
    *uber*)                             echo "$line;leisure;delivery;food" ;;
    *deliveroo*)                        echo "$line;leisure;delivery;food" ;;

    # ones that are wrong, that should be personal and not common
    *carpe*diem*)                       echo "$line;wrong;haircut;marta" ;;
    *interets*debuteurs*)               echo "$line;comision;patiseria;" ;;
    *)                                  echo "$line;unknown;boh;boh" ;;
  esac
}


function _create_visidata_help() {
  cat <<EOL >> /tmp/bourso.help

VISIDATA helpers:
- general
    - change type of column:             ~ (str), # (int), % (float), $ (currency), or @ (date)
    - sort by column:                   [ and ]
    - move column to right/left:        h and l
    - hide column:                      -
    - full column width:                _
    - show all columns:                 gv
    - exit:                             q
- filter rows
    - | + text + enter selects lines and \" creates a temp table to see only those
- see only certain columns (advanced)
    1. go to columns view:    shift + C 
    2. edit columns view:     e
    3. exit:                  q
- create aggregate views
    1. set columns as key (for aggregation): !
    2. set aggregator on a given column:     +agg (like +sum) 
    3. create pivot:                         shift+w
    4. exit:                                 q
EOL
}

function _show_instructions() {

  cat <<EOL
USE:
- LOG IN into boursorama, account, Graphique, Evolution de mon solde 
- select the cards you are interested in 
- select the time period you are interested in (limits are INCLUSIVE, i.e. for a full month 2020-01-01 to 2020-01-31)
- then click on Exporter au format csv (file must land in $base/export...csv)

Press ENTER once the file has been downloaded in $base...
EOL
}

function qboursorama-analyse() {
  sql='python2-q-text-as-data  --output-header --skip-header --delimiter=; --output-delimiter=;'
  local iso_month=${1:-20}
  local base="$HOME/Downloads"
  local view_tool="vd --csv-delimiter ';' --default-width 30 --filetype csv --header 1"
  rm -f /tmp/bourso.*

  _show_instructions
  read -i xx

  local input="$(ls -t $base/export*.csv | head -1)"
  if [ -e "$input" ]
  then
	iconv -f ISO-8859-1 -t UTF-8 "$input" -o /tmp/bourso.csv.tmp1
	cat /tmp/bourso.csv.tmp1 | sed -E 's/(.*)([0-9]) ([0-9])(.*)/\1\2\3\4/g' > /tmp/bourso.csv.tmp2 # values greater than 1k are represented wrongly (for instance 1300 would be represented as 1 300 by boursorama)
        
	while IFS= read -r line
	do
	  _qboursorama-match "$line" >> /tmp/bourso.csv.tmp3
	done < /tmp/bourso.csv.tmp2

	$sql 'select substr(dateOp,7)|| "-" ||substr(dateOp,4,2)|| "-" ||substr(dateOp,1,2) as dateOpIso, substr(dateOp,7)|| "-" ||substr(dateOp,4,2) as monthOpIso,* from /tmp/bourso.csv.tmp3 where dateOpIso like "'$iso_month'%"' > /tmp/bourso.csv.tmp4

        # columns at this point: 
	# dateOpIso;monthOpIso;dateOp;dateVal;label;category;categoryParent;supplierFound;amount;accountNum;accountLabel;accountBalance;customCategory;customSubcategory;customDescription
	# 2021-03-31;2021-03;31/0..;31/03..;VIR from-fix-to-.;Virements ;Mouvements in;viremariable;112,86;40513502;FAMILIA CARTA 0930 BOURSO;16,90;internal;safe;safe

        # The idea is to group all bank account transfers into a single line representing the flow (should be equal to the feeding - actual paid expenses via bank transfer, which is to be avoided)
	$sql "\
	    select monthOpIso as dateOpIso , monthOpIso,'transfers' as newCustomCategory,'transfers' as customSubcategory,'transfers' as customDescription,'transfers' as category, 'transfers' as supplierFound, 'transfers' as accountLabel, 'transfers' as label, 'transfers' as categoryParent, sum(amount) as amount from /tmp/bourso.csv.tmp4 \
	      where customCategory == 'internal' \
	      group by monthOpIso \
	    union \
	    select dateOpIso,monthOpIso,customCategory as newCustomCategory,customSubcategory,customDescription,category,supplierFound, accountLabel, label, categoryParent, amount from /tmp/bourso.csv.tmp4 where newCustomCategory != 'internal'" \
	      > /tmp/bourso.csv

	$sql "\
	    select r.monthOpIso, r.newCustomCategory, sum(r.amount), b.budgetAmount, sum(r.amount) - b.budgetAmount as budget_left, 100*(sum(r.amount))/b.budgetAmount as percentage_consumed \
	    from \
	      /home/mjost/.dotfiles/modules/bourso/budget.csv as b \
	    left outer join \
	      /tmp/bourso.csv as r \
	    where \
	      r.newCustomCategory = b.customCategory group by r.monthOpIso, r.newCustomCategory\
	    "> /tmp/bourso.csv.budget

	$sql 'select r.monthOpIso, r.newCustomCategory as category, sum(r.amount) as consumed from /tmp/bourso.csv as r group by r.monthOpIso, r.newCustomCategory' > /tmp/bourso.csv.summary

	$sql 'select sum(amount) as balance, min(dateOpIso) as from_date_inclusive, max(dateOpIso) as until_date_inclusive from /tmp/bourso.csv.tmp4' > /tmp/bourso.csv.balance

	$sql 'select (e.amount - 0.0) as amount, 100 * (e.amount - 0.0) / b.budgetAmount as amount_budget_perc, e.newCustomCategory as category, b.budgetAmount as category_budget_amount, b.percentage_consumed as category_budget_consumed_perc, e.dateOpIso as date, e.label as label, e.customSubCategory as subcategory, e.customDescription as description, e.accountLabel as account, e.category as boursorama_category, e.supplierFound as boursorama_supplier, e.categoryParent as boursorama_category_parent from /tmp/bourso.csv as e join /tmp/bourso.csv.budget as b where e.monthOpIso = b.monthOpIso and e.newCustomCategory = b.newCustomCategory order by category_budget_consumed_perc,amount' > /tmp/bourso.csv.details

cat <<EOL >> /tmp/bourso.csv.report
REPORT

1. Lines check:
$(wc -l /tmp/bourso*)

EOL
#if [ 1 == 3 ]
#then

	_create_visidata_help
	screen -AdmS myshell -t help bash -c "less /tmp/bourso.help"
	screen -S myshell -X screen -t report bash -c "cat /tmp/bourso.csv.report | less"
	screen -S myshell -X screen -t balance bash -c "cat /tmp/bourso.csv.balance | $view_tool"
	screen -S myshell -X screen -t balance_by_category bash -c "cat /tmp/bourso.csv.summary | $view_tool"
	screen -S myshell -X screen -t balance_by_category_and_budget bash -c "cat /tmp/bourso.csv.budget | $view_tool"
	screen -S myshell -X screen -t details bash -c "cat /tmp/bourso.csv.details | $view_tool"
	screen -x myshell
#fi
  else
    echo "No $input file found!"
  fi
}
