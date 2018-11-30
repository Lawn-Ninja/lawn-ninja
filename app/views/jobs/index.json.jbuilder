json.array! @jobs do |job|
  json.id job.id
  json.user_id job.user_id
  json.user job.user
  json.provider_id job.provider_id
  json.start_time job.start_time
  json.end_time job.end_time
  json.status job.status
  json.created_at job.created_at
  json.updated_at job.updated_at
  json.requested_time job.requested_time
end