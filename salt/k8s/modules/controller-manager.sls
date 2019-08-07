# -*- coding: utf-8 -*-
#********************************************
# Author:       Long Zhang
# Email:        392572435@qq.com
# Description:  Kubernetes Controller Manager
#********************************************
{% set k8s_version = "k8s-v1.15.2" %}

kube-controller-manager-bin:
  file.managed:
    - name: /opt/kubernetes/bin/kube-controller-manager
    - source: salt://k8s/files/{{ k8s_version }}/bin/kube-controller-manager
    - user: root
    - group: root
    - mode: 755

kube-controller-manager-service:
  file.managed:
    - name: /usr/lib/systemd/system/kube-controller-manager.service
    - source: salt://k8s/templates/kube-controller-manager/kube-controller-manager.service.template
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        SERVICE_CIDR: {{ pillar['SERVICE_CIDR'] }}
        POD_CIDR: {{ pillar['POD_CIDR'] }}
  cmd.run:
    - name: systemctl daemon-reload
  service.running:
    - name: kube-controller-manager
    - enable: True
    - watch:
      - file: kube-controller-manager-service
