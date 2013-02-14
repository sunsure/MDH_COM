require 'spec_helper'

describe ApplicationHelper do
  it "shouldnt blow up with a garbage lexer" do
    expect { to_markdown("```markdown\n  thisshouldfail\n```").inspect }.to_not raise_error
  end
end
