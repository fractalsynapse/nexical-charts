{{/*
Expand the name of the chart.
*/}}
{{- define "nexical-contracts-frontend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nexical-contracts-frontend.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nexical-contracts-frontend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nexical-contracts-frontend.labels" -}}
helm.sh/chart: {{ include "nexical-contracts-frontend.chart" . }}
{{ include "nexical-contracts-frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nexical-contracts-frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nexical-contracts-frontend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nexical-contracts-frontend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nexical-contracts-frontend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "nexical-contracts-frontend.redisURL" -}}
{{- printf "redis://%s:%s@%s:%s/0" .Values.externalRedis.user .Values.externalRedis.password .Values.externalRedis.host .Values.externalRedis.port | quote }}
{{- end }}

{{- define "nexical-contracts-frontend.databaseURL" -}}
{{- printf "postgres://%s:%s@%s:%s/%s" .Values.externalDatabase.user .Values.externalDatabase.password .Values.externalDatabase.host .Values.externalDatabase.port .Values.externalDatabase.db | quote }}
{{- end }}
