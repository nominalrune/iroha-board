mkdir /projects
mkdir /projects/iroha
git clone https://github.com/nominalrune/iroha-board-Dockerized.git /projects/iroha
cd /projects/iroha
git checkout -b lbProjectTest
docker-compose build
chown -R www-data /projects/iroha/apache
docker-compose up
