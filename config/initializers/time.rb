Time.class_eval do
  # Zero out milli- & micro-seconds.
  #
  # Database engines sometimes truncate the timestamps, so tests can fail
  # when checking that a timestamp in the database is the one I specified in
  # the test, e.g. as 100.hours.from_now.
  def trunc
    change(usec: 0)
  end
end