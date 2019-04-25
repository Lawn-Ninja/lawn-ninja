require_relative "prawn-table.rb"

class Invoice
  include Prawn::View

  def initialize(job)
    @job = job
    title
    producer_info
    consumer_info
    line_items
    bottom_message
  end

  def title
    text "Invoice for Job #{@job.id}", align: :center, size: 24
    move_down 20
  end

  def producer_info
    text "Provider: #{@job.provider.first_name} #{@job.provider.last_name}"
    text "Provider ##{@job.provider.id}"
    move_down 10
    text "Lawn Ninja"
    text "405 N Madison Ave"
    text "Pasadena, CA 91101"
    move_down 20
  end

  def consumer_info
    text "Billed To:"
    text "#{@job.consumer.first_name} #{@job.consumer.last_name}"
    text "#{@job.consumer.address}"
    text "#{@job.consumer.city}, #{@job.consumer.state} #{@job.consumer.zip_code}"
    move_down 20
  end

  def line_items
    provider_cut = "$20.00"
    company_cut = "$5.00"
    total = "$25.00"
    table([
      ["Item Description", "Amount", "Paid"],
      ["Lawn Care", provider_cut, "Credit ####-####-####-0001"],
      ["Fees", company_cut, "Credit ####-####-####-0001"],
      ["", "  ", ""],
      ["Total", total, "Paid in Full"]
    ], :width => 500)
    move_down 20
  end

  def bottom_message
    text "For questions about this invoice, please visit www.lawnninja.com or call (262) 313-8767.", align: :center, size: 11
    move_down 20
    text "Thank you for choosing Lawn Ninja!", align: :center, style: :bold
  end
end