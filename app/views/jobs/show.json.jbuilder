json.id @job.id
json.consumer_id @job.consumer_id
json.consumer_name @job.consumer.first_name
json.provider_id @job.provider_id
json.provider_name @job.provider && @job.provider.first_name
json.start_time @job.start_time
json.end_time @job.end_time
json.status @job.status
json.created_at @job.created_at
json.updated_at @job.updated_at
json.requested_time @job.requested_time