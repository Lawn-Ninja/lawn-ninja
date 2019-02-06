json.requested_jobs do
  json.array! @jobs["requested_jobs"] do |job|
    json.id job.id
    json.consumer_id job.consumer_id
    json.consumer job.consumer
    json.provider_id job.provider_id
    json.start_time job.start_time
    json.end_time job.end_time
    json.status job.status
    json.created_at job.created_at
    json.updated_at job.updated_at
    json.requested_time job.requested_time
  end
end
json.scheduled_jobs do
  json.array! @jobs["scheduled_jobs"] do |job|
    json.id job.id
    json.consumer_id job.consumer_id
    json.consumer job.consumer
    json.provider_id job.provider_id
    json.start_time job.start_time
    json.end_time job.end_time
    json.status job.status
    json.created_at job.created_at
    json.updated_at job.updated_at
    json.requested_time job.requested_time
  end
end
json.in_progress_jobs do
  json.array! @jobs["in_progress_jobs"] do |job|
    json.id job.id
    json.consumer_id job.consumer_id
    json.consumer job.consumer
    json.provider_id job.provider_id
    json.start_time job.start_time
    json.end_time job.end_time
    json.status job.status
    json.created_at job.created_at
    json.updated_at job.updated_at
    json.requested_time job.requested_time
  end
end
json.completed_jobs do
  json.array! @jobs["completed_jobs"] do |job|
    json.id job.id
    json.consumer_id job.consumer_id
    json.consumer job.consumer
    json.provider_id job.provider_id
    json.start_time job.start_time
    json.end_time job.end_time
    json.status job.status
    json.created_at job.created_at
    json.updated_at job.updated_at
    json.requested_time job.requested_time
  end
end 