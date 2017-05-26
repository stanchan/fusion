${connection_strings_fusion_api}
${connection_strings_fusion_indexer}
${connection_strings_fusion_solr}
${connection_strings_fusion_zookeeper}

${public_ip_address_bastion}

[bastion-host]
${list_bastion}

[fusion-api]
${list_fusion_api}

[fusion-indexer]
${list_fusion_indexer}

[fusion-solr]
${list_fusion_solr}

[fusion-zookeeper]
${list_fusion_zookeeper}

[fusion-cluster:children]
fusion-api
fusion-indexer
fusion-solr

[fusion-api:vars]
${elb_api_fqdn}
${elb_api_port}
