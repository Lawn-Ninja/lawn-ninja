class JobsController < ApplicationController
  def jobs_near_me
    p "in jobs_near_me"
    if current_provider
      # p current_provider
      @jobs = Job.jobs_near_me(current_provider.zip_code, current_provider.id) 
      # p @jobs
      render "index.json.jbuilder"
    else
      render json: {jobs: []}
    end
  end

  def my_jobs
    @jobs = {
      "requested_jobs" => [],
      "scheduled_jobs" => [],
      "in_progress_jobs" => [],
      "completed_jobs" => []
    }
    status_key = {
      "posted" => "requested_jobs",
      "claimed" => "scheduled_jobs",
      "started" => "in_progress_jobs",
      "completed" => "completed_jobs"
    }

    if current_consumer
      current_consumer.jobs.each do |job|
        @jobs[status_key[job.status]] << job
      end
    end
    
    if current_provider
      current_provider.jobs.each do |job|
        @jobs[status_key[job.status]] << job
      end
    end
    # @jobs = current_user.jobs + Job.where(provider_id: current_user.id)
    render json: {jobs: @jobs}
  end

  def new
    render 'new.html.erb'
  end

  def create
    @job = Job.new(job_params)
    @job.status = "posted"
    @job.consumer_id = current_consumer.id
    if @job.save
      render json: {job: @job}
    else
      render json: {errors: @job.errors.full_messages}, status: :unprocessible_entity
    end

  end

  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(job_params)
      render json: {job: @job}
    else
      render json: {errors: @job.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def show
    @job = Job.find(params[:id])
    render 'show.json.jbuilder'
  end

  private

    def job_params
      params.require(:job).permit(:requested_time, :start_time, :end_time, :provider_id, :status)
    end
end
