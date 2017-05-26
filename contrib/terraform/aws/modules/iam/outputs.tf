output "fusion-api-profile" {
    value = "${aws_iam_instance_profile.fusion-api.name }"
}

output "fusion-indexer-profile" {
    value = "${aws_iam_instance_profile.fusion-indexer.name }"
}

output "fusion-solr-profile" {
    value = "${aws_iam_instance_profile.fusion-solr.name }"
}
