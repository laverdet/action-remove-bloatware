# Remove GitHub Runner Bloatware

This is a GitHub action which removes extraneous bloatware on action runners. This is useful if your
workflow generates large artifacts and you're running out disk space.

```yaml
- uses: laverdet/remove-bloatware@v1.0.0
```

You can also decide not to remove certain packages and tools:
```yaml
inputs:
  docker:
    type: boolean
    description: Keep Docker
  lang:
    type: choice
    description: Keep target language
    options:
      - dotnet
      - java
      - rust
```

For example:
```yaml
- uses: laverdet/remove-bloatware@v1.0.0
  with:
    docker: true
    lang: rust
```

See the following issues for extra information:
- actions/runner-images#10237
- actions/runner-images#10386
- actions/runner-images#10414
