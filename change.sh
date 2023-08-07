#!/bin/sh
set -e
goal="Improve documentation for referencing .md files"
echo "Plan:"
echo "1. Add a new section called 'Attributes referencing .md files' between 'Attributes' and 'Template Files'"
echo "2. Include an example referring to the task: prompt/task/feature/implement.md line in the example yaml"
echo "3. Show the content of prompt/task/feature/implement.md to supplement the example"

# Step 1: Insert the new section
cat << 'EOF' > docs/temp_descriptor.md
# Prompt Descriptor

The prompt descriptor is a YAML file (prompt.yaml) that outlines the details necessary for generating a task prompt for the AI model. It is used to specify the task, attention, requirements, and other attributes.

## Example

```yaml
task: prompt/task/feature/implement.md
attention:
  - src/interactiveSession/startInteractiveSession.js
  - src/prompt/createPrompt.js
  - src/attention/readAttention.js
  - prompt.yaml
requirements: >
  Write a README.md for this _exploratory_ project!
```

## Attributes

- task: Describes the task type and scope.
- attention: Lists the files and directories most relevant to the task.
- requirements: Describes the actual task in a human-readable format.
- format: (Optional and half-working) Determines how the output will be formatted. It should be avoided for now.
- os: (Default: "Debian") Specifies the operating system.
- installedTools: Allows to overwrite attributes in prompt.yaml or create prompt/attributeName.md with the content.

## Attributes referencing .md files

When a yaml attribute refers to an existing file, its content will be used. For example, the line task: prompt/task/feature/implement.md in the example yaml refers to an existing markdown file and its content is injected into the task.

Here's the content of prompt/task/feature/implement.md as a supplement to the example:

```
Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

<%= requirements %>

<%= projectSpecifics %>
```

## Template Files

Prompt parts are markdown template files, and [ejs](https://ejs.co/) runs on them. Attributes from the yaml file are available in the template, e.g., <%= requirements %> injects the requirements.

EOF

# Step 2: Replace the original descriptor file with the new version
mv docs/temp_descriptor.md docs/descriptor.md

echo "\033[32mDone: $goal\033[0m\n"