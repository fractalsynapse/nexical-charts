{{/*
Expand the name of the chart.
*/}}
{{- define "nexical-contracts-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nexical-contracts-app.fullname" -}}
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
Create a default fully qualified portal name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nexical-contracts-app.portal.fullname" -}}
{{- printf "%s-%s" .Release.Name "portal" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "nexical-contracts-app.portal.label" -}}
app.kubernetes.io/component: "portal"
{{- end }}

{{/*
Create a default fully qualified api name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nexical-contracts-app.api.fullname" -}}
{{- printf "%s-%s" .Release.Name "api" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "nexical-contracts-app.api.label" -}}
app.kubernetes.io/component: "api"
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nexical-contracts-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nexical-contracts-app.labels" -}}
helm.sh/chart: {{ include "nexical-contracts-app.chart" . }}
{{ include "nexical-contracts-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: {{ .Chart.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nexical-contracts-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nexical-contracts-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.component }}
app.kubernetes.io/component: {{ .Values.component | quote }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nexical-contracts-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nexical-contracts-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "nexical-contracts-frontend.redisURL" -}}
{{- printf "rediss://%s:%s@%s:%s?ssl_cert_reqs=CERT_NONE" .Values.externalRedis.user .Values.externalRedis.password .Values.externalRedis.host .Values.externalRedis.port | quote }}
{{- end }}

{{- define "nexical-contracts-frontend.databaseURL" -}}
{{- printf "postgres://%s:%s@%s:%s/%s" .Values.externalDatabase.user .Values.externalDatabase.password .Values.externalDatabase.host .Values.externalDatabase.port .Values.externalDatabase.db | quote }}
{{- end }}

