# my-java-app-chart/templates/_helpers.tpl

{{/* Define a default `fullname` template */}}
{{- define "mychart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name }}
{{- end -}}

{{/* Define a template to generate labels */}}
{{- define "mychart.labels" -}}
app.kubernetes.io/name: {{ include "mychart.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Define a template to generate selector labels */}}
{{- define "mychart.selectorLabels" -}}
{{ include "mychart.labels" . | nindent 4 }}
{{- end -}}

