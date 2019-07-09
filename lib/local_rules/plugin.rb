require 'git_diff_parser'

module Danger
  class DangerLocalRules < Plugin

    attr_accessor :rules_file

    def rules_file
      return @rules_file || '.danger_local_rules.yml'
    end

    def check
      diff = github.pr_diff
      return if diff.nil?

      failure_rules = rules['failure']
      warning_rules = rules['warning']
      return if failure_rules.nil? && warning_rules.nil?

      if diff.match(Regexp.union(failure_rules.keys + warning_rules.keys))
        regexp_to_fail = Regexp.union(failure_rules.keys)
        regexp_to_warn = Regexp.union(warning_rules.keys)

        GitDiffParser.parse(diff).each do |changed_file|
          next if changed_file.file == '.danger_local_rules.yml'
          changed_file.changed_lines.each do |changed_line|
            content = changed_line.content
            # Only checks added contents
            next unless content.start_with?('+')

            if (content.match(regexp_to_fail))
              content.match(regexp_to_fail) do |data|
                fail(failure_rules[data[0]], file: changed_file.file, line: changed_line.number)
              end
            end

            if (content.match(regexp_to_warn))
              content.match(regexp_to_warn) do |data|
                warn(warning_rules[data[0]], file: changed_file.file, line: changed_line.number)
              end
            end
          end
        end
      end
    end

    private

    def rules
      YAML.load_file(rules_file)
    end
  end
end
