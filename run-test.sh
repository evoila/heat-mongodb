openstack stack create -t test/mongodb.yaml\
 -e test/lib/heat-iaas/resources.yaml\
 -e test/lib/heat-common/resources-$1.yaml\
 -e resources-$1.yaml\
 --parameter key=$2\
 --parameter image=$3\
 --parameter flavor=$4\
 --parameter public_network=$5\
 --wait\
 test-mongodb
