class Job < ApplicationRecord
  belongs_to :consumer
  validates :requested_time, presence: true

  def self.jobs_near_me(provider_zip, current_consumer_id)
    jobs = []
    radius_miles = 5

    zip_codes = HTTP.get("https://www.zipcodeapi.com/rest/#{ENV['API_KEY']}/radius.json/#{provider_zip}/#{radius_miles}/mile?minimal").body.to_s.delete('{\"zip_codes\":[').delete(']}').split(',')

    zip_codes.each do |zc|
      int_zc = zc.to_i
      if int_zc > 0 && int_zc < 100000
        consumers = Consumer.where("zip_code = '#{int_zc.to_s}'")
        consumers.each do |consumer|
          if consumer.id != current_consumer_id
            consumer.jobs.each do |job|
              if job.status == "posted"
                jobs << job
              end
            end
          end
        end
      end
    end
    jobs
  end

  def provider
    provider_id && Provider.find(provider_id)
  end
end
