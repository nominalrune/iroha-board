mkdir /projects
mkdir /projects/iroha
git clone https://github.com/nominalrune/iroha-board-Dockerized.git /projects/iroha
cd /projects/iroha
git checkout -b lbProjectTest
chown -R www-data apache
docker-compose up --build
echo FINISHED
