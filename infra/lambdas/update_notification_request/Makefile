create-zip-file:
	docker build -t lambda-ruby2.7-nokogiri .
	docker run --rm -it -v $$PWD:/var/task -w /var/task lambda-ruby2.7-nokogiri make _install
	rm -f lambda.zip
	zip -q -r lambda.zip .

# Commands that start with underscore are run *inside* the container.

_install:
	bundle config --local set clean true
	bundle config --local set path 'vendor/bundle'
	bundle config --local silence_root_warning true
	bundle install
