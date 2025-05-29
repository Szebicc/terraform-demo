output "docdb_endpoint" {
  value       = aws_docdb_cluster.mongodb.endpoint
  description = "Endpoint for connecting to the DocumentDB cluster"
}

output "docdb_reader_endpoint" {
  value       = aws_docdb_cluster.mongodb.reader_endpoint
  description = "Reader endpoint for DocumentDB cluster"
}