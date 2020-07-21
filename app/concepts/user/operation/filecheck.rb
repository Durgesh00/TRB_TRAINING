class User::Operation::Filecheck < Trailblazer::Operation

  require 'csv'
  step :accept_file
  step :is_file_empty?, 
    Output(:success) => Id(:empty_error),
    Output(:failure) => Track(:convert)#

  fail :empty_error, fail_fast: :true#, id: :invalid_online_method

  step :conversion, magnetic_to: :convert,
    Output(:success) => Track(:validate),
    Output(:failure) => Track(:failure)#Id(:send_error_conversion)

  fail :send_error_conversion, fail_fast: :true

  step :validation, magnetic_to: :validate,
    Output(:success) => Track(:database),
    Output(:failure) => Track(:failure)#Id(:send_error_validation)

  step :send_error_validation, magnetic_to: :database
  
  def accept_file(ctx, file_name:, **)
     ctx[:file_name] = file_name

     file = File.open(file_name, "r")
     p "inside accept_file"
  end

  def is_file_empty?(ctx, file_name:, **)
    p "inside method is_file_empty"
    #puts File.zero?(file_name)
    return File.zero?(file_name)
  end

  def conversion(ctx, file_name:, **)
   csv_table = CSV.parse(File.read(file_name), headers: true)
   #puts csv_table
   
   json_string = csv_table.map(&:to_h).to_json
   puts json_string
   ctx[:json_string] = json_string
   p "inside conversion"
  end

  def validation(ctx, **)
    puts ctx[:json_string]
    p "inside validation"
    true
  end

  def data_store(ctx, **)
    p "inside data store"
  end

  def empty_error(ctx, **)
    p "File is empty"
  end

  def send_error_conversion(ctx, **)
    p "inside send_error_conversion"
  end

  def send_error_validation(ctx, file_name:, **)
    p "inside send_error_validation"
    CSV.open(file_name, "w+", headers: false) do |row|
      dob = row[1]
      row << "Age should be above 18" if get_age(dob) < 18
    end
  end
end
