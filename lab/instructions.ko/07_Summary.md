# 요약

이 실습에서 여러분은 다음을 학습했습니다.

- 비즈니스 시나리오에 가장 적합한 모델을 선택하기 위해 모델을 탐색하고 비교하기
- 프롬프트와 데이터를 사용해 더 정확하고 근거 있는(grounded) 응답을 얻도록 모델을 보강하기
- MCP(Model Context Protocol)를 통해 모델과 지시문(instructions), 도구를 결합하여 내부용 에이전트를 프로토타이핑하기
- 추가 커스터마이징 및 배포를 위해 에이전트 코드를 추출하기

이 과정을 통해, AI-powered 애플리케이션 개발을 간소화하도록 설계된 Visual Studio Code의 Foundry Toolkit을 직접 사용해 보는 실습 경험도 쌓았습니다.

## 다음 단계(Next steps)

AI 에이전트 개발을 계속 진행하고 프로덕션 환경 배포를 고려할 때, 아래 몇 가지 중요한 사항을 함께 고려하세요.

- **Azure hosted models**: 프로덕션 시나리오에서는 Azure에 호스팅된 모델을 사용하는 것이 권장됩니다. 이러한 모델은 더 나은 성능, 신뢰성, 그리고 엔터프라이즈 표준에 부합하는 컴플라이언스를 제공합니다. [Microsoft Foundry Models](https://ai.azure.com/catalog)에서 카탈로그를 확인할 수 있습니다.
- **Evaluation**: 에이전트를 배포하기 전에 성능을 충분히 평가하는 것이 중요합니다. 정확성, 관련성, 안전성에 대한 테스트가 포함되어야 하며, 자동화된 테스트와 사람 평가를 혼합하는 방식을 고려하세요. 자세한 내용은 [공식 문서](https://code.visualstudio.com/docs/intelligentapps/evaluation)를 참고하세요.
- **Deployment**: 배포 시에는 요구사항에 가장 잘 맞는 인프라와 플랫폼을 고려해야 합니다. 예를 들어 이 실습에서 프로토타이핑한 구성( Microsoft Agent Framework 기반 Python 앱 + Microsoft Foundry 호스팅 모델 + MCP 서버)은 [Microsoft Foundry Hosted Agents](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents)를 통해 배포할 수 있습니다. 이를 통해 Microsoft가 관리하는 종량제(pay-as-you-go) 인프라에서 컨테이너 이미지로 배포할 수 있습니다.
- **Monitoring**: 배포 후에는 실제 사용 환경에서 에이전트의 성능을 지속적으로 모니터링하세요. 이를 통해 문제나 개선점을 빠르게 식별할 수 있습니다. 로깅과 알림 메커니즘을 구성해 에이전트 동작과 성능 지표를 추적하세요. Microsoft Foundry의 관측성(observability) 기능이 도움이 될 수 있습니다. 자세한 내용은 [공식 문서](https://learn.microsoft.com/azure/ai-foundry/how-to/monitor-applications)를 참고하세요.
- **Continuous improvement**: AI 에이전트는 지속적으로 개선할 수 있습니다. 사용자 피드백을 수집하고 에이전트 상호작용을 분석해 개선 영역을 찾으세요. 모델, 프롬프트, 도구를 정기적으로 업데이트해 효과와 관련성을 유지합니다.

## 집에서 다시 해보기(Try this at home)

이 실습은 여러분이 원할 때 언제든지 다시 진행할 수 있습니다. 전체 실습 지침과 리소스는 공식 GitHub 리포지토리에서 확인할 수 있습니다.

https://github.com/microsoft/aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol
