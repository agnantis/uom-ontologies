#!/bin/bash

while getopts :f:d: o; do
  case "$o" in
    f )  filename="$OPTARG";;
    d )  dirname="$OPTARG";;
    \?)  echo "Usage $0 [-f filename | -d directory]"
         exit 1;;
  esac
done

if [[ ! -z "$filename" ]]; then
  fileList="$filename"
elif [[ -d "$dirname" ]]; then
  fileList=$(find $dirname -type f -iname "*owl")
else
  echo "Usage $0 [-f filename | -d directory]"
fi

for f in $fileList; do
  # Classes
  classes=$(grep -i \(Class\( $f | wc -l)
  # Object properties
  objProp=$(grep -i \(ObjectProperty\( $f | wc -l)
  # Data properties
  dataProp=$(grep -i \(DataProperty\( $f | wc -l)
  # Equivalent Classes
  eqClasses=$(grep -i EquivalentClasses\( $f | wc -l)
  # Sunclass axioms
  subClasses=$(grep -i SubClassOf\( $f | wc -l)
  # Named individuals
  namedInds=$(grep -i \(NamedIndividual\( $f | wc -l)
  # print results
  echo -e "------------------------------------------"
  echo -e "- Filename: $(basename $f)"
  echo -e "------------------------------------------"
  echo -e "   Classes:            $classes"
  echo -e "   Equivalent Classes: $eqClasses"
  echo -e "   Subclasses:         $subClasses"
  echo -e "   Object properties:  $objProp"
  echo -e "   Data properties:    $dataProp"
  echo -e "   Named Individuals:  $namedInds"
  echo -e "------------------------------------------"
  echo -e ""
done
