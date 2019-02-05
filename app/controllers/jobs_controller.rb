class JobsController < ApplicationController
  def jobs_near_me
    # p "in jobs_near_me"
    if current_provider
      # p current_provider
      @jobs = Job.jobs_near_me(current_provider.zip_code) 
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

    if params[:job][:user_type] == "consumer"
      current_consumer.jobs.each do |job|
        @jobs[status_key[job.status]] << job
      end
    end
    if params[:job][:user_type] == "provider"
      current_provider.jobs.each do |job|
        @jobs[status_key[job.status]] << job
      end
    end
    render "my_jobs.json.jbuilder"
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
      render 'show.json.jbuilder'
    else
      render json: {errors: @job.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def show
    @job = Job.find(params[:id])
    render 'show.json.jbuilder'
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    render json: {}
  end

  private

    def job_params
      params.require(:job).permit(:requested_time, :start_time, :end_time, :provider_id, :status, :user_type)
    end
end
