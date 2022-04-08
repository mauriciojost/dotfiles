# wget https://dlcdn.apache.org/avro/avro-1.11.0/java/avro-tools-1.11.0.jar
AVRO_TOOLS_JAR=$HOME/opt/zips/avro-tools-1.11.0.jar

function qavro-read() {
  INPUT_AVRO=$1
  OUTPUT=$1
  java -jar $AVRO_TOOLS_JAR cat --offset 0 --limit 2 --samplerate 1 $INPUT_AVRO $OUTPUT
}

function qavro-count() {
  INPUT_AVRO=$1
  java -jar $AVRO_TOOLS_JAR count $INPUT_AVRO 
}
