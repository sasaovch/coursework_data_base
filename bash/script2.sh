psql -d studs -h pg -c "\copy locality from '/home/studs/s336768/backup/locality.csv' delimiter ',' csv header"
echo 'copy locality'
psql -d studs -h pg -c "\copy church from '/home/studs/s336768/backup/church.csv' delimiter ',' csv header"
echo 'copy church'
psql -d studs -h pg -c "\copy prison from '/home/studs/s336768/backup/prison.csv' delimiter ',' csv header"
echo 'copy prison'
psql -d studs -h pg -c "\copy bible from '/home/studs/s336768/backup/bible.csv' delimiter ',' csv header"
echo 'copy bible'
psql -d studs -h pg -c "\copy commandment from '/home/studs/s336768/backup/commandment.csv' delimiter ',' csv header"
echo 'copy commandment'
psql -d studs -h pg -c "\copy bible_commandment from '/home/studs/s336768/backup/bible_commandment.csv' delimiter ',' csv header"
echo 'copy bible_commandment'
psql -d studs -h pg -c "\copy person from '/home/studs/s336768/backup/person.csv' delimiter ',' csv header"
echo 'copy person'
psql -d studs -h pg -c "\copy official from '/home/studs/s336768/backup/official.csv' delimiter ',' csv header"
echo 'copy official'
psql -d studs -h pg -c "\copy inquisition_process from '/home/studs/s336768/backup/inquisition_process.csv' delimiter ',' csv header"
echo 'copy inquisition_process'
psql -d studs -h pg -c "\copy accusation_process from '/home/studs/s336768/backup/accusation_process.csv' delimiter ',' csv header"
echo 'copy accusation_process'
psql -d studs -h pg -c "\copy accusation_record from '/home/studs/s336768/backup/accusation_record.csv' delimiter ',' csv header"
echo 'copy accusation_record'
psql -d studs -h pg -c "\copy punishment from '/home/studs/s336768/backup/punishment.csv' delimiter ',' csv header"
echo 'copy punishment'
psql -d studs -h pg -c "\copy violation from '/home/studs/s336768/backup/violation.csv' delimiter ',' csv header"
echo 'copy violation'
psql -d studs -h pg -c "\copy torture_type from '/home/studs/s336768/backup/torture_type.csv' delimiter ',' csv header"
echo 'copy torture_type'
