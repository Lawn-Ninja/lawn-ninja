class Job < ApplicationRecord
  belongs_to :consumer
  validates :requested_time, presence: true

  def self.jobs_near_me(provider_zip)
    jobs = []
    radius_miles = 5

    request_url = "https://www.zipcodeapi.com/rest/#{ENV['API_KEY']}/radius.json/#{provider_zip}/#{radius_miles}/mile?minimal"

    zip_codes_raw = HTTP.get(request_url)
    zip_codes = JSON.parse zip_codes_raw.body, symbolize_names: true

    p zip_codes

    zip_codes[:zip_codes].each do |zc|
      int_zc = zc.to_i
      if int_zc > 0 && int_zc < 100000
        consumers = Consumer.where("zip_code = '#{zc}'")
        consumers.each do |consumer|
          consumer.jobs.each do |job|
            if job.status == "posted"
              jobs << job
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
