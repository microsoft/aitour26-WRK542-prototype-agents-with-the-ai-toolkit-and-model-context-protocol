# 모델 보강(Model Augmentation): 컨텍스트를 강화해 성능 높이기

이 섹션에서는 프롬프트 엔지니어링과 컨텍스트 데이터를 사용해 선택한 모델을 보강(augment)하여, 성능과 유스케이스 적합도를 높이는 방법을 학습합니다. 이는 비즈니스 시나리오의 고유한 요구사항에 맞게 AI 모델을 튜닝하는 데 중요한 단계입니다.

## Step 1: 시스템 메시지(System Message) 작성

시스템 메시지는 AI 모델의 행동과 컨텍스트를 설정하는 프롬프트의 핵심 구성 요소입니다. 모델이 자신의 역할과 작업 요구사항을 이해하도록 돕습니다. 효과적인 시스템 메시지를 만들기 위한 핵심 포인트는 다음과 같습니다.

1. **명확하고 간결하게**: 상호작용의 목적과 원하는 결과를 명확히 표현합니다. 모호함을 피해야 모델이 작업을 제대로 이해합니다.

2. **컨텍스트 제공**: 더 정확하고 상황에 맞는 응답을 생성하도록, 관련 배경 정보를 포함합니다.

3. **기대치 설정**: 응답의 형식, 길이, 스타일 등 제약 사항이나 요구사항을 명시합니다.

4. **복잡한 지시를 분해**: 작업이 복잡한 경우, 단계별 지시로 나눠 모델이 따라가기 쉽게 구성합니다.

먼저 Playground의 채팅 기록을 지워서 깨끗한 상태에서 시작합니다. 화면 왼쪽 상단의 **New Playground**를 클릭하세요.

![New Playground](../../img/new_playground.png)

Playground 오른쪽 패널의 **System Prompt** 필드에 아래 시스템 메시지를 입력합니다.

```
You are Cora, an internal assistant for Zava (a DIY retailer). You help store managers and head office staff analyze sales and manage inventory.

Your role is to:
- Ask clarifying questions to understand the reporting or inventory request.
- Provide concise, actionable summaries and recommendations.
- Be careful with operational actions: if asked to move inventory, you must ask for explicit confirmation first.
- Be brief in your responses.
Your personality is:
- Professional, precise, and helpful
- Curious and practical—never assume, always clarify

Stick to Zava store operations, sales analysis, and inventory topics. If asked something outside of that, politely say you can only assist with Zava-related operational requests.

Always respond in Korean.
```

![System Prompt](../../img/system_prompt.png)

이 메시지에는 다음이 포함되어 있습니다.
- 어시스턴트의 **역할과 책임**(내부 매장 운영 + 본사 분석)
- **응답 방식**에 대한 명확한 가이드(간결함, 실행 가능, 확인 우선)
- 운영 액션에 대한 **안전 가드레일**(재고 이동 요청 시 반드시 명시적 확인)

## Step 2: 멀티모달 입력으로 시스템 메시지 테스트

시스템 프롬프트를 설정했으니, 이제 멀티모달 사용자 프롬프트로 테스트합니다. Playground 채팅에서 이미지 첨부 아이콘을 클릭해 대화 컨텍스트에 이미지를 업로드하고, 아래 경로의 차단기(circuit breaker) 이미지를 선택합니다.

```    
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png
```

그리고 다음 사용자 프롬프트를 함께 입력합니다.

영문 프롬프트
```
Here’s a photo from the store floor. What is this component, and what details should I capture (e.g., amperage, pole type) before searching our catalog and checking stock?
```

한글 프롬프트
```
매장 현장에서 찍은 사진입니다. 이 부품이 무엇인지, 그리고 카탈로그 검색 및 재고 확인 전에 (전류 용량, 극 수 등과 같이) 어떤 정보를 기록해야 하는지 알려주세요.
```

종이비행기 아이콘을 클릭해 멀티모달 프롬프트를 실행합니다.
모델은 이미지를 분석하고, 설명과 함께 카탈로그 검색 및 재고 확인 전에 확인해야 할 사항을 제안합니다. 응답이 시스템 메시지의 기대(간결함, 확인 우선 등)에 부합하는지 확인해 보세요.

다음으로 Zava 비즈니스와 무관한 질의를 입력해 봅니다.

```
What’s the weather like in Seoul today? 
```

모델은 Zava 관련 문의만 지원할 수 있다고 정중히 안내해야 합니다. 이는 모델이 시스템 메시지에 설정된 가이드라인을 따르는지 확인하는 테스트입니다.

## Step 3: 그라운딩 데이터(Grounding Data) 추가

시스템 메시지 외에도, 컨텍스트 데이터를 제공하면 모델이 더 관련성 높고 정확한 응답을 생성하는 데 큰 도움이 됩니다. 컨텍스트 데이터에는 회사/제품/서비스 정보 등 시나리오 이해에 필요한 정보가 포함될 수 있습니다.

이 유스케이스에서는 Zava의 제품 카탈로그 일부를 컨텍스트로 제공해, 내부 질문에 대해 제품 정보를 지어내지 않도록 합니다.

그라운딩 데이터를 추가하기 위해 Playground의 **file attachment** 기능을 사용합니다. 이 기능을 통해 모델이 참조할 문서를 업로드할 수 있습니다.

업로드할 문서는 Zava 제품 카탈로그 일부를 담은 JSON 파일입니다. 내용을 확인하려면 **data** 폴더에서 **zava_product_catalog.json** 파일을 찾아 열어보세요.

1. Playground로 돌아와 프롬프트 입력 영역의 파일 첨부 아이콘을 클릭합니다.
![File attachment icon](../../img/file_attachment_icon.png)
2. `/data/` 디렉터리에서 `zava_product_catalog.json` 파일을 선택합니다.

> [!TIP]
> 파일 선택 창에서 데이터 디렉터리는 아래 경로에 있습니다.
> ```
>C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\data
> ```

![Uploading Grounding Data File](../../img/uploading_grounding_data_file.png)

3. 업로드가 완료되면 프롬프트 입력 영역 아래에 첨부 파일로 표시됩니다.
4. 텍스트 필드에 아래 프롬프트를 입력합니다.

영문 프롬프트
```
From the attached Zava product catalog, suggest a circuit breaker option that would commonly be used for a 15-amp household circuit, and explain what you would verify before recommending it.
```

한글 프롬프트
```
첨부된 Zava 제품 카탈로그에서 15암페어 가정용 회로에 일반적으로 사용되는 차단기 옵션을 하나 추천하고, 이를 추천하기 전에 어떤 사항을 확인해야 하는지 설명해 주세요.
```

모델은 업로드된 제품 카탈로그를 분석해, 차단기 요청에 맞는 근거 있는 제안을 제공합니다.

내부적으로는, 첨부 데이터가 프롬프트 컨텍스트에 자동 포함되므로 모델이 더 많은 정보를 바탕으로 응답할 수 있습니다.

물론 이 방식에는 한계가 있습니다. 모델이 프롬프트 컨텍스트에서 처리할 수 있는 텍스트 양에는 제한이 있고, 첨부 컨텍스트가 커질수록 응답 지연과 비용이 증가합니다. 더 큰 데이터셋이나 복잡한 시나리오에서는, 현재 사용자 질의와 가장 관련 있는 정보만 프롬프트에 포함하도록 하는 더 정교한 검색/추출 메커니즘이 필요합니다. 다음 섹션에서 이를 더 자세히 살펴보겠습니다.

## Key Takeaways
- 효과적인 시스템 메시지는 모델의 행동을 안내하고 관련성 높은 응답을 얻는 데 매우 중요합니다.
- 파일 첨부를 통한 컨텍스트 데이터 제공은 모델의 성능과 관련성을 크게 향상할 수 있습니다.
- 멀티모달 입력 테스트는 시스템 메시지와 컨텍스트 데이터의 효과를 검증하는 데 도움이 됩니다.
- 그라운딩 데이터는 모델 입력 제한 내에 들어가도록 관련성이 높고 간결해야 합니다.

다음 실습 세션으로 가기 위해서 아래 **다음**을 클릭하세요.
