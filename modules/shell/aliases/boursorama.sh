function qboursorama-match() {
  local line="$1"
  case $line in
    *categoryParent*)                   echo "$line;customCategory;customSubcategory;customDescription" ;; # header

    # weekly shopping
    *carrefour*)                        echo "$line;shopping;food;regular" ;;
    *bioman*)                           echo "$line;shopping;food;bio" ;;
    *francis*viande*)                   echo "$line;shopping;food" ;;
    *LIVRAIS-EXPRES*)                   echo "$line;shopping;food;livraison express carrefour" ;;
    *picard*surgeles*)                  echo "$line;shopping;food;compras picard" ;;
    *boucherie*de*la*tour*)             echo "$line;shopping;food;compras carne" ;;
    *le*neptune*)                       echo "$line;shopping;food;martatoexplain" ;;
    *biocoop*)                          echo "$line;shopping;food;bio" ;;
    *BIOBULLE*)                         echo "$line;shopping;food;compras bio" ;;
    *QUENTIN*POISSO*)                   echo "$line;shopping;food;fish" ;;
    **BONTA*ITALIANE*)                  echo "$line;shopping;boulangerie;cosas italianas para comer" ;;
    *ADEGAS*WINE*)                      echo "$line;shopping;boulangerie;compras vinos" ;;
    *aurora*)                           echo "$line;shopping;boulangerie;panaderia" ;;
    *le*fournil*saint*francois*)        echo "$line;shopping;boulangerie;boulangerie" ;;
    *sc*armand*piet*)                   echo "$line;shopping;boulangerie;boulangerie" ;;
    *la*boulangerie*)                   echo "$line;shopping;boulangerie;boulangerie" ;;
    *PAUL*REPUBLIQUE*)                  echo "$line;shopping;boulangerie;panaderia en av de la republique" ;;
    *cep*boulanger*)                    echo "$line;shopping;boulangerie;panaderia" ;;
    *hoggar*viandes*)                   echo "$line;shopping;food;meat" ;;
    *lart*et*le*pain*)                  echo "$line;shopping;boulangerie;panaderia" ;;

    # maison
    *eurodif*)                          echo "$line;shopping;property;bazar" ;;
    *carre*blanc*)                      echo "$line;shopping;property;bazar" ;;
    *bricorama*)                        echo "$line;shopping;property;repair" ;;

    # baby
    *DR*DE*PAZ*)                        echo "$line;baby;health;" ;;
    *sergent*major*)                    echo "$line;baby;clothes;" ;;
    *wedoogift*)                        echo "$line;baby;games;" ;;
    *VENTE*PRIVEE*)                     echo "$line;baby;clothes;" ;;
    *pinocchio*)                        echo "$line;baby;games;" ;;
    *la*grande*recr*)                   echo "$line;baby;games;" ;;
    *barbe*de*papa*)                    echo "$line;baby;haircut;" ;;
    *OEUVRE*DES*CRECHES*DE*NICE*)       echo "$line;baby;creche;" ;;
    *du*pareil*au*me*)                  echo "$line;baby;clothes;" ;;
    *VERTBAUDET*)                       echo "$line;baby;clothes;" ;;
    *decathlon*)                        echo "$line;baby;sport;decathlon" ;;

    # transport
    *escota*)                           echo "$line;leisure;transport;peages escota" ;;
    *STATION*AVIA*)                     echo "$line;leisure;transport;fuel avia" ;;
    *PAYBYPHONE*NIC*)                   echo "$line;service;parking;auto parking mensual" ;;
    *AGIP*)                             echo "$line;service;transport;fuel agip" ;;

    # trip
    *VOLOTEA*)                          echo "$line;leisure;trip;plane" ;;
    *rla*automate*)                     echo "$line;leisure;transport;unknown" ;;

    # tech
    *amazon*)                           echo "$line;leisure;amazon;" ;;
    *fnac*)                             echo "$line;leisure;fnac;" ;;

    # sante
    *VIRTO*FE*MAR*)                     echo "$line;health;general;" ;;
    *pharmacie*)                        echo "$line;health;pharmacie;" ;;
    *GRAS*SAVOYE*)                      echo "$line;health;mutuel;gras savoye" ;;

    # taxes
    *DIRECTION*GENERALE*DES*FINANCE*)   echo "$line;tax;unknown" ;;
    *caf*alpes*)                        echo "$line;tax;caf;" ;;

    # insurance
    *CPAM*061*NICE*)                    echo "$line;insurance;securite-social;securite-social" ;;
    *axa*)                              echo "$line;insurance;assurance voiture" ;;
    *CRCAM*PROVENCE*)                   echo "$line;insurance;assurance habitation" ;;

    # property
    *VIR*SEPA*LE*DOMINO*)               echo "$line;property;charges;" ;;
    *VIR*P1APPELDESFONDS*)              echo "$line;property;charges;" ;;

    # service
    *edf*)                              echo "$line;service;edf;electricity" ;;
    *google*)                           echo "$line;service;googledrive;nas" ;;
    *VIR*P1*INTERNET*TV*)               echo "$line;service;tvinternet;" ;;

    # vetement
    *HETM234*)                          echo "$line;basic;clothes;" ;;

    # marta unknown
    *selvi*didier*)                     echo "$line;leisure;unclear;martatoexplain" ;;
    *jm*et*mf*)                         echo "$line;leisure;unclear;martatoexplain" ;;
    *zara*home*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *adav*)                             echo "$line;leisure;unclear;martatoexplain" ;;
    *OUEST*HARMONIE*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *CDISCOUNT*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *TRIBECA*)                          echo "$line;leisure;unclear;martatoexplain" ;;
    *veze*contac*)                      echo "$line;leisure;unclear;martatoexplain" ;;
    *LOUISE*LE*CLUB*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *paul*)                             echo "$line;leisure;unclear;martatoexplain" ;;
    *GIORGESCHI*)                       echo "$line;leisure;unclear;martatoexplain" ;;
    *SC*AURORA*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *PLAISIR*DES*HA*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *alice*delice*)                     echo "$line;leisure;unclear;martatoexplain" ;;
    *vinted*fr*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *VIVAL*SC*)                         echo "$line;leisure;unclear;martatoexplain" ;;
    *EK*SALEYA*)                        echo "$line;leisure;unclear;martatoexplain" ;;
    *L*AGRUME*)                         echo "$line;leisure;unclear;martatoexplain" ;;
    *ETS*CARANTA*)                      echo "$line;leisure;unclear;martatoexplain" ;;
    *sc*goodfood*)                      echo "$line;leisure;unclear;martatoexplain" ;;
    *PASTRY*PLAISIR*)                   echo "$line;leisure;unclear;martatoexplain" ;;
    *ARMEE*ALPES*)                      echo "$line;leisure;unclear;mauritoexplain" ;;

    # feeding operations
    *FAIRNESS*)                         echo "$line;feeding;fairness;fairness move mauri" ;;
    *VIR*SEPA*RANIERI*730*)             echo "$line;feeding;fairness;fairness move marta" ;;
    *Salaire*fix*)                      echo "$line;feeding;fairness;fairness move martax" ;;

    # internal operations
    *SEPA*RANIERI*MARTA*Virements*re*)  echo "$line;internal;safe;safe move" ;;
    *safe*)                             echo "$line;internal;safe;safe move;" ;;
    *sos*)                              echo "$line;internal;safe;safe move;" ;;
    *INTERETS*DEBITEURS*)               echo "$line;internal;service;boursorama;" ;;
    *Mouvements*internes*)              echo "$line;internal;safe;safe;" ;;
    *VIR*Interne*)                      echo "$line;internal;virement interne;" ;;

    ## leisure
    # food
    *ATELIERROSEMOO*)                   echo "$line;leisure;unclear;calendarios" ;;
    *LEONIDAS*)                         echo "$line;leisure;boulangerie;boulangerie chic" ;;
    *jeff*de*bruges*)                   echo "$line;leisure;boulangerie;marta chocolates chic" ;;
    *CANET*MACCARAN*)                   echo "$line;leisure;boulangerie;boulangerie chic" ;;
    *LAC*BARLA*)                        echo "$line;leisure;boulangerie;boulangerie chic" ;;
    *LEKOBE*)                           echo "$line;leisure;luxury;sushi" ;;
    *PATISSERIE*)                       echo "$line;leisure;unclear;patiseria" ;;
    *burlet*location*de*skis*)          echo "$line;leisure;ski;ski" ;;
    *tiger*)                            echo "$line;leisure;unclear;tiger" ;;
    *delices*de*la*republique*)         echo "$line;leisure;unclear;patiseria" ;;
    *pane*e*olio*)                      echo "$line;leisure;restaurant;coulee verte" ;;
    # food delivery
    *uber*)                             echo "$line;leisure;delivery;food" ;;
    *deliveroo*)                        echo "$line;leisure;delivery;food" ;;

    # ones that are wrong, that should be personal and not common
    *carpe*diem*)                       echo "$line;wrong;haircut;marta" ;;
    *INTERETS*DEBUTEURS*)               echo "$line;comision;patiseria;" ;;
    *)                                  echo "$line;unknown;boh;boh" ;;
  esac
}
function qboursorama-analyse() {
  local base="$HOME/Downloads"
  local base="$HOME/Downloads"
  rm -f /tmp/bourso.*
  echo "Remember to:"
  echo "- go to Evolution de mon solde "
  echo "- select the card you are interested in "
  echo "- select the time period you are interested in (remember that limits are inclusive, i.e. for a full month 2020-01-01 to 2020-01-31)"
  echo "- then click on Exporter au format csv (file must land in $HOME/Downloads/export...csv)"
  echo ""
  echo "Press ENTER once the file has been downloaded..."
  read -i xx
  local input="$(ls -t $base/export*.csv | head -1)"
  if [ -e "$input" ]
  then
	iconv -f ISO-8859-1 -t UTF-8 "$input" -o /tmp/bourso.csv.tmp
	cat /tmp/bourso.csv.tmp | sed -E 's/(.*)([0-9]) ([0-9])(.*)/\1\2\3\4/g' > /tmp/bourso.csv.tmp2 # values greater than 1k are represented wrongly (for instance 1300 would be represented as 1 300 by boursorama)

        
	while IFS= read -r line
	do
	  qboursorama-match "$line" >> /tmp/bourso.csv.tmp3
	done < /tmp/bourso.csv.tmp2


	python2-q-text-as-data --output-header --skip-header --delimiter=';' --output-delimiter=';' 'select *, substr(dateOp,7)|| "-" ||substr(dateOp,4,2)|| "-" ||substr(dateOp,1,2) as dateOpIso from /tmp/bourso.csv.tmp3' > /tmp/bourso.csv

	screen -AdmS myshell -t balance bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select sum(amount) as balance, min(dateOpIso) as from_date_inclusive, max(dateOpIso) as until_date_inclusive from /tmp/bourso.csv' | fzf --no-sort"

	screen -S myshell -X screen -t summary_budget bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select substr(r.dateOpIso, 1,7) as month, r.customCategory as category, sum(r.amount) as consumed, b.budgetAmount as budget, b.budgetAmount - sum(r.amount) as diff from /home/mjost/.dotfiles/modules/bourso/budget.csv as b left join /tmp/bourso.csv as r  where r.customCategory = b.customCategory group by month, r.customCategory' | fzf --no-sort"
	screen -S myshell -X screen -t summary bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select sum(amount), substr(dateOpIso, 1,7) as month, customCategory from /tmp/bourso.csv group by customCategory, month order by sum(amount)' | fzf --no-sort"

	screen -S myshell -X screen -t summary++ bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select sum(amount), customCategory, customSubCategory, customDescription from /tmp/bourso.csv group by customCategory, customSubCategory, customDescription order by sum(amount)' | fzf --no-sort"
	screen -S myshell -X screen -t details bash -c "python2-q-text-as-data -b --output-header --skip-header --delimiter=';' 'select dateOpIso as date, (amount - 0.0) as amnt, customCategory, customSubCategory, customDescription, category as cat, supplierFound as supplier, accountLabel as account, label, categoryParent as catPar from /tmp/bourso.csv order by amnt' | fzf --no-sort"
	screen -x myshell
  else
    echo "No $input file found!"
  fi
}
