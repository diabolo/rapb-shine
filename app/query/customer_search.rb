class CustomerSearch

  attr_reader :where_clause, :where_args, :order, :q

  def initialize(q)
    @q = q.downcase
    @where_clause = ""
    @where_args = {}
    if q =~ /@/
      email_search
    else
      name_search
    end
  end

  private

  def name_search
    @where_clause << case_insensitive(:first_name)
    @where_args[:first_name] = starts_with(q)

    @where_clause << " OR #{case_insensitive(:last_name)}"
    @where_args[:last_name] = starts_with(q)

    @order = "last_name asc"
  end

  def email_search
    @where_clause << case_insensitive(:first_name)
    @where_args[:first_name] = starts_with(extract_name(q))

    @where_clause << " OR #{case_insensitive(:last_name)}"
    @where_args[:last_name] = starts_with(extract_name(q))

    @where_clause << " OR #{case_insensitive(:email)}"
    @where_args[:email] = q
    @order = "lower(email) = " + ActiveRecord::Base.connection.quote(q) + " desc, last_name asc"

  end

  def case_insensitive(field)
    "lower(#{field}) like :#{field}"
  end

  def starts_with(term)
    term +'%'
  end

  def extract_name(email)
    email.gsub(/@.*$/,'').gsub(/[0-9]+/,'')
  end

end
