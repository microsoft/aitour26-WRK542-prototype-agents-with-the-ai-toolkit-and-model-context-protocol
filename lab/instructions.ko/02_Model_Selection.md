# 모델 선택: AI Toolkit Model Catalog 살펴보기

이 섹션에서는 멀티모달 에이전트 프로젝트에 적합한 모델을 찾기 위해 AI Toolkit의 **Model Catalog**를 탐색하고, 필터링하고, 비교하는 방법을 학습합니다. Model Catalog는 GitHub, Microsoft Foundry, OpenAI 등 다양한 제공자의 모델에 접근할 수 있게 해줍니다.

## Step 1: 필터를 적용해 후보를 좁히기

1. 왼쪽 사이드바에서 **AI Toolkit** 확장 아이콘을 찾습니다.
2. AI Toolkit 아이콘을 클릭해 확장 패널을 엽니다.
3. **Developer Tools** 아래에서 **Discover** 섹션을 펼친 다음 **Model Catalog**를 클릭해 카탈로그 인터페이스를 엽니다.

![Model Catalog](../../img/model_catalog.png)

페이지 상단에는 가장 인기 있는 모델이 표시됩니다. 아래로 스크롤하면 전체 모델 목록을 볼 수 있습니다.

목록이 상당히 많기 때문에, 요구사항에 맞춰 필터 옵션을 사용해 후보를 좁히는 것이 좋습니다.

![Filter Options](../../img/filter_options.png)

### 호스팅 제공자(Hosting Provider)로 필터링

1. **All Filters** 드롭다운을 클릭해 `Hosted by` 목록을 표시합니다. GitHub(무료 사용 가능하지만 토큰 속도 제한이 있는 모델 제공), Microsoft Foundry, OpenAI 등이 있으며, Ollama 또는 ONNX를 통해 로컬 인프라에 호스팅된 모델을 사용할 수도 있습니다.

2. **Microsoft Foundry**를 선택해, 엔터프라이즈급 보안 및 컴플라이언스 기능을 제공하는 Foundry 호스팅 모델을 확인합니다.

### 퍼블리셔(Publisher)로 필터링

1. 필터 목록을 계속 스크롤해 **Publisher** 섹션으로 이동합니다.
2. **Meta**를 선택해 해당 제공자의 모델을 확인합니다.

### 모델 기능(Model Feature)로 필터링

1. 필터 목록을 계속 스크롤해 **Feature** 섹션으로 이동합니다. 여기에서 이미지/오디오/비디오 처리, tool calling 등 모델의 기능을 기준으로 필터링할 수 있습니다.
2. **Image Attachment**를 선택해 시각 입력을 처리하고 텍스트+이미지 멀티모달 상호작용을 지원하는 모델을 찾습니다.

## Step 2: 구독(Subscription)에 모델 배포하기

필터를 적용하면 정제된 모델 목록이 표시됩니다.
필터 결과에서 **Llama-4-Maverick-17B-128E-Instruct-FP8**를 찾습니다. 이 모델은 멀티모달 모델이며 추론 능력이 우수합니다.

2. 모델 타일의 **Deploy**를 클릭해 배포 구성 창을 엽니다.

![Add Model](../../img/add_model.png)

3. **Token Per Minute** 슬라이더를 오른쪽으로 옮겨 120K로 올립니다. 나머지 파라미터는 기본값으로 두고 **Deploy to Microsoft Foundry**를 클릭해 구독에 모델 인스턴스를 프로비저닝합니다.

![Deployment Configuration](../../img/deployment_configuration.png)

## Step 3: 테스트를 위해 Playground 열기

1. 왼쪽 사이드바에서 **My Resources** 섹션을 찾고, Microsoft Foundry 프로젝트 아래 리소스를 펼칩니다.
1. **Models** 아래에서 방금 배포한 모델 인스턴스를 확인할 수 있어야 합니다. 또한, 이 워크숍에서는 비교 테스트를 위해 미리 배포된 **gpt-5.3-chat** 인스턴스와, 다음 섹션에서 벡터 검색 및 RAG에 사용할 **text-embedding-3-small** 인스턴스도 보일 것입니다.
1. 방금 배포한 모델 인스턴스를 오른쪽 클릭한 뒤 드롭다운 메뉴에서 **Open in Playground**를 선택해 Playground에서 테스트를 시작합니다.
![Try in playground](../../img/try_in_playground.png)

2. **Model** 필드에 선택한 모델 이름이 표시됩니다.

![Model Playground](../../img/model_playground.png)

> [!WARNING]
> 특히 Playground를 처음 여는 경우 모델 로딩이 다소 지연될 수 있습니다. 모델이 초기화되는 동안 잠시 기다려 주세요.

3. **Compare** 버튼을 클릭해 좌우 비교 모드를 활성화합니다.
4. 드롭다운에서 Microsoft Foundry에 이 워크숍용으로 미리 배포된 **gpt-5.3-chat** 배포를 선택합니다.
5. 이제 두 모델을 비교 테스트할 준비가 끝났습니다.

![Model Comparison](../../img/model_comparison.png)

## Step 4: 텍스트 생성 및 멀티모달 기능 테스트

> [!TIP]
> 좌우 비교 기능을 사용하면, 서로 다른 모델이 동일 입력을 어떻게 처리하는지 정확히 비교할 수 있어 유스케이스에 최적인 모델을 선택하기 쉬워집니다.

먼저 간단한 프롬프트로 모델과 상호작용을 시작합니다.

1. 텍스트 입력 필드(“Type a prompt” 플레이스홀더가 보이는 영역)에 아래 프롬프트를 입력합니다.

```
나는 DIY 소매점의 매장 관리자입니다. 주간 매출 요약에서 검토해야 할 가장 중요한 지표는 무엇이며, 그 이유는 무엇인가요?
```

2. 종이비행기 아이콘을 클릭해 두 모델에서 동시에 프롬프트를 실행합니다.

![Test the model](../../img/test_the_model.png)

다음으로 아래 프롬프트로 추론 능력을 테스트합니다.

```
우리는 A, B, C 세 개의 매장을 운영하고 있으며, 세 매장을 합쳐 사용할 수 있는 차단기(circuit breaker)는 총 40개뿐입니다. 다음 보충 재고는 10일 후에 도착합니다. 

아래는 판매 추세와 현재 재고에 대한 간단한 스냅샷입니다: 

| 매장 | 판매추세(주간대비) | 주간 평군 판매량 | 현재재고(개) |
|------:|-------------------:|----------------------:|----------------------:|
| A     | +30%              | 18                    | 8                     |
| B     | 0%                | 10                    | 22                    |
| C     | -15%              | 7                     | 10                    |

오늘 재고를 어떻게 배분해야 품절(stockout)과 판매 손실을 최소화할 수 있을까요?

그 이유를 단계별로 설명하고, 추가로 확인해야 할 가장 중요한 데이터 3가지를 제시하세요.
```

다음으로 모델의 이미지 처리 능력을 테스트합니다.

1. 텍스트 입력 필드에 아래 프롬프트를 입력합니다.

```
이 이미지에 무엇이 들어 있는지, 그리고 어떤 종류의 전기 부품으로 보이는지 설명하세요.
```

2. 이미지 첨부 아이콘을 클릭해 입력으로 이미지를 추가합니다.

![Image Attachment](../../img/image_attachment.png)

3. 업로드할 이미지 파일을 선택하는 탐색 창이 표시됩니다. 아래 경로로 이동합니다.

```
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions
```

그 다음 **circuit_breaker.png** 파일을 선택하고 **Open**을 클릭합니다.

![Image File Path](../../img/image_file_path.png)

4. 두 모델에서 동시에 멀티모달 프롬프트를 전송합니다.

## Step 5: 결과 분석 및 비교

아래 요소들을 기준으로 두 모델의 출력 결과를 검토합니다.

- **Response Quality**: 설명의 깊이와 정확성, 그리고 입력 프롬프트와의 일관성을 비교합니다.
- **Detail Level**: 어느 모델이 더 포괄적인 분석을 제공하는지 확인합니다.
- **Processing Time**: 응답 속도 차이를 관찰합니다.
- **Output Formatting**: 응답의 명확성과 구성, 그리고 장황함(verbosity)을 평가합니다. 장황함은 토큰 사용량과 비용에 영향을 줄 수 있습니다.

### GitHub Copilot으로 비교 분석 보조하기

비교 분석을 더 쉽게 진행하기 위해 GitHub Copilot을 사용해 비교 요약을 생성할 수 있습니다.

GitHub Copilot Chat을 열려면 Visual Studio Code 상단의 **Toggle Chat** 아이콘을 선택합니다.

![Toggle chat button.](../../img/toggle-chat.png)

`Auto`를 선택한 다음 `Other models`를 선택해 *Claude Opus 4.5*를 고릅니다.

> [!TIP]
> 드롭다운의 메인 목록에서 보이지 않으면 `Other models` 섹션을 확장해 Claude Opus 4.5 모델을 찾으세요.

![Select claude Opus 4.5](../../img/select_claude_opus.png)

> [!WARNING]
> 로그인되어 있지 않으면 모델을 선택할 수 없습니다. 이전 실습 섹션에 따라 GitHub Copilot 로그인을 완료했는지 확인하거나, 프롬프트를 보내 로그인 플로우를 트리거하세요.

Copilot Chat 창에서 아래 프롬프트를 시도합니다.

한글 프롬프트
```
#mcp_azure_mcp_foundry 미국 전역에 20개의 매장을 보유하고 온라인 채널도 운영하는 DIY 소매업체 Zava를 지원할 AI 에이전트 모델을 검토하고 있습니다. 이 에이전트는 매장 운영과 본사 매출 분석을 지원해야 합니다.
Llama-4-Maverick-17B-128E-Instruct-FP8 모델과 OpenAI GPT-5.3-chat 모델을 평가 중인데, 이 시나리오에는 어느 모델을 추천하시며 그 이유는 무엇인가요?
또한 모델 간의 트레이드오프(예: 추론 능력, 비용, 지연 속도, 컨텍스트 길이 등)를 설명해 주어 제가 정보를 기반으로 선택할 수 있도록 도와주세요.
```
영문 프롬프트
```
#mcp_azure_mcp_foundry I am exploring models for an AI agent that should support Zava - a DIY retailer with 20 stores across the United States and an online channel - on store operations and head office sales analysis. I am evaluating Llama-4-Maverick-17B-128E-Instruct-FP8 and OpenAI GPT-5.3-chat. Which one would you recommend for this scenario, and why? Explain the trade-offs between models (e.g., reasoning ability, cost, latency, context length) so that I can make an informed choice
```

이 질문에 답하기 위해 Copilot은 *Foundry MCP server* 도구를 사용합니다. 이 도구는 유스케이스에 기반한 모델 추천을 제공합니다. Copilot이 Foundry MCP server 도구 접근 승인을 요청하면 **Allow in this session**을 클릭해 진행합니다.  
**분석에 필요한 정보를 수집하기 위해 여러 도구 접근이 반복해서 요청될 수 있습니다.**

![Get AI model guidance](../../img/get_ai_model_guidance.png)

최종 응답에는 두 모델의 상세 비교와, 에이전트 프로젝트에 어떤 모델을 선택하는 것이 좋은지에 대한 추천이 포함되어야 합니다.

## Step 6: Microsoft Foundry에서 선택한 모델 가져오기

비교가 끝나면 다음 실습 섹션에서 추가 프로토타이핑을 진행하기 위해 두 모델 중 하나를 선택합니다. 이 실습에서는 **GPT-5.3-chat**를 선택하겠습니다.

> [!TIP]
> 단일 패널/단일 모델로 돌아가려면 모델 이름 오른쪽에 있는 **Select this model**을 클릭합니다.
>
> ![Select this model](../../img/select_this_model.png)

## Key Takeaways

- Model Catalog는 여러 제공자의 다양한 AI 모델을 한눈에 볼 수 있게 해줍니다.
- 필터링을 통해 요구사항에 맞는 모델 후보를 빠르게 찾을 수 있습니다.
- Playground의 모델 비교 기능으로 데이터 기반 의사결정을 할 수 있습니다.
- 호스팅 옵션마다 개발 단계에 따라 서로 다른 장점이 있습니다.
- 내장된 비교 기능으로 멀티모달 기능을 효과적으로 테스트할 수 있습니다.

이 탐색 과정을 통해 성능, 비용, 기능, 배포 요구사항의 균형을 고려하여 유스케이스에 가장 적합한 모델을 선택할 수 있습니다.  
다음 실습 섹션을 위해 아래에서 **다음**을 눌러주세요.
