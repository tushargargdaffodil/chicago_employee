require "chicago_employee/version"
require "unirest"
module ChicagoEmployee
  #Define the api for getting the employees data
  ChicagoAPI = "https://data.cityofchicago.org/resource/xzkq-xp2w.json"
  class Employee
    attr_reader :title, :department, :name, :salary, :last_name, :first_name 

    def initialize(input_options)
      @job_title = input_options["job_titles"]
      @department = input_options["department"]
      @name = input_options["name"]
      @salary = input_options["annual_salary"].to_i
      @first_name = @name.split(", ")[1]
      @last_name = @name.split(", ")[0]
    end

    def self.all
     Unirest.get(ChicagoAPI)
      .body
      .map { |employee| Employee.new(employee) }
    end

    def self.find(key,option)
      ruby_data = []
      bulk_data = Unirest.get(ChicagoAPI+'?'+key+"=#{option}").body
      bulk_data.each do |employee|
        ruby_data << Employee.new(employee)
      end
      ruby_data
    end

    def self.highest_paid
      employees = Unirest.get(ChicagoAPI)
       .body
       .map { |employee| Employee.new(employee) }
      employees.max_by { |employee| employee.salary }
    end
  end
end
