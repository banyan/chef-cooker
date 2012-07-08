require "chef-cooker/version"
require 'thor'
require 'thor/group'

module Chef
  module Cooker
    class Generator < Thor::Group
      include Thor::Actions

      argument :cookbook

      def manifest
        generate_cookbook
        append_package
        add_and_commit_with_git
      end

      def generate_cookbook
        `bundle exec knife cookbook create #{cookbook} --cookbook-path cookbooks`
      end

      def append_package
        if yes? "Do you want to append package to cookbooks/#{cookbook}/recipes/default.rb"
          append_file "cookbooks/#{cookbook}/recipes/default.rb", deindent(<<-EOS)
            package "#{cookbook}"
          EOS
        end
      end

      def add_and_commit_with_git
        if yes? 'Do you want to commit'
          git add: "cookbooks/#{cookbook}", commit: "-m \"Add #{cookbook}\""
        end
      end

      private
      # Run a command in git.
      #
      #   git :init
      #   git :add => "this.file that.rb"
      #   git :add => "onefile.rb", :rm => "badfile.cxx"
      def git(commands={})
        if commands.is_a?(Symbol)
          run "git #{commands}"
        else
          commands.each do |cmd, options|
            run "git #{cmd} #{options}"
          end
        end
      end

      def append_newline(path)
        gsub_file path, /\z/, "\n"
      end

      def deindent(string, width = nil)
        width ||= string.lines.grep(/./).map do |line|
          line[/^ */].length
        end.min || 0
        string.gsub(/^ {#{width}}/, '')
      end
    end
  end
end
