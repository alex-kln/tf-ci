output "topic_name" {
  description = "Name of created pubsub topic"
  value       = google_pubsub_topic.example_resource.name
}
