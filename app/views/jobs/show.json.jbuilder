json.id @job.id
json.user_id @job.user_id
json.user_name @job.user.name
json.provider_id @job.provider_id
json.provider_name @job.provider && @job.provider.name
json.start_time @job.start_time
json.end_time @job.end_time
json.status @job.status
json.created_at @job.created_at
json.updated_at @job.updated_at
json.requested_time @job.requested_time