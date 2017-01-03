##SVU Ebooks

* Populate a text file with the plot descriptions of SVU episodes from IMDb, Hulu, and Rotten Tomatoes. Make sure you have a Hulu API key

  ```
  $ HULU_AUTH_TOKEN=foo pry
  ```

  ```ruby
  require './svu_ebooks'
  SvuEbooks::Populator.new.run!
  ```


* Use `twitter_ebooks` to turn our results into something it understands

  ````
  $ ebooks consume svu.txt
  ```


* Build an `Ebooks::Model` and make statements of any character length

  ```ruby
  require 'twitter_ebooks'
  model = Ebooks::Model.load("model/svu.model")
  model.make_statement(rand(100..400))
  ```
