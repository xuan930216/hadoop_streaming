%%bash

OUT_DIR="wordcount_result_for_rating"
NUM_REDUCERS=8

hdfs dfs -rm -r -skipTrash ${OUT_DIR} > /dev/null

yarn jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -D mapred.jab.name="Streaming wordCount" \
    -D mapreduce.job.reduces=${NUM_REDUCERS} \
    -files mapper.py,reducer.py \
    -mapper "python mapper.py" \
    -combiner "python reducer.py" \
    -reducer "python reducer.py" \
    -input /data/wiki/en_articles_part \
    -output ${OUT_DIR} > /dev/null


OUT_DIR_2="wordcount_result_for_rating_2"
NUM_REDUCERS=1

hdfs dfs -rm -r -skipTrash ${OUT_DIR_2} > /dev/null

yarn jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -D mapred.jab.name="Streaming wordCount Rating" \
    -D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
    -D map.output.key.field.separator=\t \
    -D mapreduce.partition.keycomparator.options=-k1,1nr \
    -D mapreduce.job.reduces=${NUM_REDUCERS} \
    -files mapper_rating.py,reducer_rating.py \
    -mapper "python mapper_rating.py" \
    -reducer "python reducer_rating.py" \
    -input ${OUT_DIR} \
    -output ${OUT_DIR_2} > /dev/null

hdfs dfs -cat ${OUT_DIR_2}/part-00000 | head -7 | tail -1