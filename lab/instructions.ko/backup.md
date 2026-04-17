@lab.Title
# 소개  
>[!NOTE]
> 이 워크숍은 **75분** 동안 진행되며, Visual Studio Code에서 Foundry Toolkit과 Microsoft Foundry를 활용해 비즈니스 시나리오에 맞는 멀티모달 에이전트를 프로토타이핑하는 실습 경험을 제공합니다.

## 학습 목표  
이 워크숍을 마치면 다음을 수행할 수 있습니다:

• Foundry Toolkit 모델 카탈로그에서 다양한 모델을 탐색하고 비교하여, 사용 사례에 가장 적합한 모델을 선택할 수 있습니다.  

• Foundry Toolkit Playground에서 프롬프트 엔지니어링과 컨텍스트 데이터를 활용해 모델을 보강하고, 더 정확하고 근거 있는 응답을 생성할 수 있습니다.  

• Foundry Toolkit Agent Builder를 사용해 MCP(Model Context Protocol) 기반 도구와 지침을 결합하여 에이전트를 프로토타이핑할 수 있습니다.  

## 리소스  
> [!TIP]
> 로그인 정보와 구독 정보는 **Resources** 탭에서 확인할 수 있습니다.

## 랩 요약  

이 랩은 Microsoft Foundry와 Foundry Toolkit을 사용해 멀티모달 에이전트를 프로토타이핑하는 전체 과정을 4개의 섹션으로 구성해 안내합니다.

1. **파트 1 - 모델 선택**  
   AI 솔루션을 구축할 때 모델 선택은 핵심 단계입니다. 이 섹션에서는 Foundry Toolkit의 모델 카탈로그를 탐색하며, 비즈니스 시나리오에 가장 적합한 모델을 비교·선택합니다.

2. **파트 2 - 모델 보강**  
   선택한 모델을 프롬프트 엔지니어링과 컨텍스트 데이터를 활용해 보강하여, 특정 사용 사례에 더 적합한 성능과 관련성을 확보하는 방법을 배웁니다.

3. **파트 3 - 에이전트 프로토타이핑**  
  Foundry Toolkit Agent Builder를 사용해 에이전트를 프로토타이핑합니다. 선택하고 보강한 모델을 MCP(Model Context Protocol) 기반 도구 및 지침과 결합합니다.

4. **파트 4 - 프로토타입에서 코드로**  
   마지막으로, 프로토타입을 실제 애플리케이션에 통합할 수 있는 코드 형태로 내보내는 방법을 학습합니다.

## 비즈니스 시나리오  

이 워크숍에서는 **Zava**라는 미국 내 **20개 매장과 온라인 채널을 운영하는 DIY(셀프 인테리어) 소매업체**를 위한 AI 에이전트를 구축합니다.  
시나리오는 **매장 운영**과 **본사 판매 분석**에 초점을 맞추며, 재고 확인 및 매장 간 재고 이동 기능도 포함합니다.

### 문제 상황

Zava의 매장 관리자와 본사 팀은 다음과 같은 질문에 빠르게 답할 수 있어야 합니다:

• "지난달 가장 많이 판매된 카테고리는 무엇인가요?"  
• "핵심 상품의 재고가 부족한 매장은 어디인가요?"  
• "수요를 충족하기 위해 한 매장의 재고를 다른 매장으로 이동할 수 있을까요?"  

또한, 사진(예: 차단기 사진)을 기반으로 제품을 식별하고, 재고를 확인하고, 필요한 조치를 취하는 등 멀티모달 작업도 수행해야 합니다.

### 해결책: Zava 매장 운영 및 판매 분석 에이전트 **Cora**

여러분은 다음 기능을 수행하는 내부용 AI 어시스턴트 **Cora**를 개발하게 됩니다:

1. **멀티모달 입력 이해**: 직원이 제공하는 텍스트와 이미지(예: 제품 사진, SKU 라벨)를 처리  
2. **제품 카탈로그 검색**: 자연어 질의 또는 이미지 기반 설명을 활용해 관련 제품을 찾기  
3. **운영 의사결정 지원**: 판매 실적 관련 질문에 답변하고 실행 가능한 요약 제공  
4. **재고 확인**: 온라인 및 오프라인 매장의 실시간 재고 데이터 조회  
5. **안전한 재고 이동 처리**: 매장 간 재고 이동 요청을 생성하고 명시적 확인 절차 수행  

### 왜 중요한가  

이 에이전트는 Zava가 다음을 달성하도록 돕습니다:

• **더 빠른 판매 인사이트 제공**으로 의사결정 향상  
• **재고 부족 감소** - 낮은 재고를 조기에 파악하고 매장 간 이동 가능  
• **보고서 표준화** - 매장 관리자와 본사 팀 간 일관된 보고  
• **멀티채널 운영 지원** - 매장과 온라인 간 재고 조정  

이 워크숍을 통해 여러분은 Foundry Toolkit과 Microsoft Foundry를 사용해 Cora의 기능을 구축·테스트·개선하며, 실제 비즈니스 시나리오에 적용 가능한 AI 에이전트를 만드는 방법을 배우게 됩니다.


===
# 01-시작하기

> [!TIP] 
> **Foundry Toolkit**이란 무엇인가요?  
> Foundry Toolkit은 Visual Studio Code용 확장으로, 다양한 AI 모델과 서비스를 하나의 통합된 인터페이스에서 탐색하고 상호작용할 수 있도록 해주는 도구입니다.  
> 이를 통해 개발자는 GitHub, Microsoft Foundry, 로컬 환경 등 여러 플랫폼에 호스팅된 오픈소스 및 상용 모델을 쉽게 비교·활용할 수 있습니다.  
> Foundry Toolkit은 모델 선택, 프롬프트 엔지니어링, 에이전트 프로토타이핑 및 테스트를 코드 편집기 안에서 직접 수행할 수 있도록 하여 생성형 AI 개발 워크플로우를 크게 향상시킵니다.

## Windows에 로그인하기

첫 번째 단계로, **Resources** 탭에서 제공되는 Skillable VM 자격 증명을 사용해 랩 가상 머신(VM)에 로그인합니다.

![VM login credentials](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/vm_login_credentials.png)

> [!TIP]
> **Skillable을 처음 사용하나요?**  
> "T" 아이콘(예: +++Admin+++)은 VM 내에서 현재 커서 위치에 값을 자동으로 입력해주는 기능입니다.  
> 클릭 한 번으로 입력 오류를 줄이고 작업 속도를 높일 수 있습니다.  
> 또한, 모든 이미지는 필요할 때 클릭하여 확대할 수 있습니다.

## GitHub에 로그인하기

이 워크숍에서는 GitHub Enterprise(GHE) 계정을 사용하여 Foundry Toolkit Model Catalog의 GitHub 호스팅 모델과 Visual Studio Code의 GitHub Copilot 기능을 활용합니다.

아래 단계에 따라 GitHub Enterprise(GHE) 계정으로 로그인하고, 이 랩을 위한 Codespace를 생성합니다.

1. 작업 표시줄에서 Edge 브라우저를 엽니다.  
   이미 **[GHE 로그인 페이지](https://github.com/enterprises/skillable-events)**가 열려 있습니다.

2. 다음 자격 증명으로 로그인합니다:

- Username: +++@lab.CloudPortalCredential(User1).Username+++  
- TAP: +++@lab.CloudPortalCredential(User1).TAP+++  

로그인 성공 알림을 받으면 브라우저 탭을 최소화하고 Visual Studio Code에서 워크숍 환경을 엽니다.

## Visual Studio Code에서 워크숍 환경 열기

VM에 로그인한 후, 화면 하단 작업 표시줄의 터미널 아이콘을 클릭하여 터미널을 엽니다.

![Open terminal](https://raw.githubusercontent.com/microsoft/aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/open_terminal.png)

아래 명령 블록을 터미널에 복사·붙여넣기하고 **Enter**를 누릅니다.  
이 명령은 워크숍 리포지토리를 업데이트하고, Python 가상 환경을 활성화하며, VS Code에서 프로젝트를 엽니다.

```powershell
; cd $HOME\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\ ` 
; git pull ` 
; Remove-Item -Recurse -Force .git ` 
; .\.venv\Scripts\activate ` 
; code . 
```
> [!NOTE]
> 여러 줄을 터미널에 붙여넣는 것에 대한 경고가 표시됩니다. **Paste anyway**를 클릭해 계속 진행하세요.

## Azure 인증하기

Visual Studio Code 환경에는 이미 두 가지 확장이 설치되어 있어야 합니다:

- **Foundry Toolkit**: 이 랩에서 다양한 AI 모델 및 서비스와 상호작용하는 데 사용합니다.
- **Microsoft Foundry 확장**: Foundry Toolkit 패키지의 일부로 설치되며, Microsoft Foundry에서 호스팅되는 모델에 접근할 수 있습니다.  
  두 확장이 올바르게 설치되어 있다면 아래 스크린샷처럼 VS Code 왼쪽 사이드바에 아이콘이 표시됩니다.

![Installed extensions](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/installed_extensions.png)

> [!TIP]
> 아이콘이 보이지 않는다면, 사이드바 하단의 **…**(더보기)를 클릭해 전체 확장 목록을 확인하세요.

이제 Microsoft Foundry 확장 아이콘을 클릭한 뒤  
**Set Default Project** → **Sign in to Azure**를 선택합니다.

![Set Default Project](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/set_default_project.png)

Azure 로그인 팝업이 나타나면 **Allow**를 클릭합니다.

![Azure Login Popup](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/azure_login_popup.png)

이후 나타나는 창에서 다음 자격 증명을 입력합니다:

- Email: +++@lab.CloudPortalCredential(User1).Username+++  
- TAP: +++@lab.CloudPortalCredential(User1).TAP+++  

> [!NOTE]
> "이 장치에서 모든 앱과 사이트에 자동 로그인 허용" 메시지가 표시되면 **Yes, all apps**를 선택하세요.  
> 이후 **Done**을 클릭해 로그인 절차를 완료하고 VS Code로 돌아갑니다.

VS Code로 돌아오면 사용할 Foundry 프로젝트를 선택하라는 메시지가 표시됩니다.  
이 워크숍을 위해 미리 배포된 단일 프로젝트를 선택합니다.

![Select Project](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_project.png)

## GitHub Copilot AI 기능 활성화

이 워크숍에서는 GitHub Copilot의 AI 기능도 사용합니다.  
이를 위해 앞서 Edge 브라우저에서 로그인했던 동일한 GitHub Enterprise(GHE) 계정으로 VS Code에서도 로그인해야 합니다.

1. VS Code 오른쪽 하단의 **Copilot 아이콘**(현재 "Signed out" 표시)을 클릭합니다.
2. **Sign in to use AI features** → **Continue with GitHub**을 선택합니다.

![GitHub Copilot Sign In](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/github_copilot_sign_in.png)

3. 새 브라우저 탭이 열리면 **Continue**를 클릭해 동일한 GHE 계정으로 로그인합니다.  
   다음 화면에서 **Authorize Visual Studio Code**를 클릭합니다.

![Authorize GitHub Copilot](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/authorize_github_copilot.png)

4. 브라우저가 Visual Studio Code를 열려고 한다는 메시지가 표시되면  
   **Open Visual Studio Code**를 클릭해 VS Code로 돌아옵니다.

## 시작할 준비 완료

이제 VS Code에서 Foundry Toolkit과 Microsoft Foundry 모델을 사용할 준비가 완료되었습니다.  
다음 단계에서는 모델 카탈로그를 탐색하고 모델과 상호작용해 보겠습니다.

**Next**를 클릭해 다음 섹션으로 이동하세요.


===
# 02-모델 선택

모델 선택: Foundry Toolkit Model Catalog 탐색

이 섹션에서는 Foundry Toolkit Model Catalog를 탐색하여 멀티모달 에이전트 프로젝트에 사용할 모델을 발견하고, 필터링하고, 비교하는 방법을 배웁니다.  
모델 카탈로그는 GitHub, Microsoft Foundry, OpenAI 등 다양한 제공업체의 모델에 접근할 수 있도록 합니다.

## 1단계: 필터 적용하여 선택 범위 좁히기

1. 왼쪽 사이드바에서 **Foundry Toolkit** 아이콘을 찾습니다.  
2. 아이콘을 클릭하여 확장 패널을 엽니다.  
3. **Model Catalog**를 클릭하여 사용 가능한 모델 목록으로 이동합니다.

![Model Catalog](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_catalog.png)

페이지 상단에는 인기 모델이 표시되며, 아래로 스크롤하면 전체 모델 목록을 볼 수 있습니다.

모델이 많기 때문에 필터 옵션을 사용하여 필요에 맞게 목록을 좁힐 수 있습니다.

![Filter Options](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/filter_options.png)

### 호스팅 제공업체(Hosted by)로 필터링

1. **Hosted by** 필터 드롭다운을 클릭합니다.  
   GitHub, Microsoft Foundry, OpenAI, Ollama, ONNX 등 다양한 옵션이 있습니다.

2. **GitHub**을 선택하여 프로토타이핑에 적합한 무료 모델을 확인합니다.

> [!NOTE]
> GitHub 모델은 무료로 사용할 수 있어 시작하기에 좋지만, 토큰 사용량 제한이 있습니다.  
> 비용 걱정 없이 실험할 수 있지만, 프로덕션 배포 시에는 GitHub 또는 Microsoft Foundry의 종량제(pay‑as‑you‑go) 옵션을 고려하세요.

### 퍼블리셔(Publisher)로 필터링

1. **Publisher** 필터 드롭다운을 클릭하여 Microsoft, Meta, Cohere 등 모델 제공업체별로 필터링합니다.  
2. **OpenAI**와 **Mistral AI**를 선택하여 두 주요 제공업체의 모델을 확인합니다.

### 모델 기능(Feature)로 필터링

1. **Feature** 필터 드롭다운을 클릭하여 이미지/오디오/비디오 처리, 툴 호출 등 기능별로 필터링합니다.  
2. **Image Attachment**를 선택하여 텍스트 + 이미지 입력을 지원하는 멀티모달 모델을 찾습니다.

## 2단계: 모델을 컬렉션에 추가하기

필터를 적용하면 모델 목록이 좁혀집니다.

이번 실습에서는 다음 두 모델을 찾습니다:

- **OpenAI GPT‑4o** - 강력한 멀티모달 모델  
- **Mistral Small 3.1** - 빠르고 비용 효율적인 경량 모델  

> [!TIP]
> 두 모델이 보이지 않으면 **View All**을 클릭해 전체 필터링된 목록을 확인하세요.  
> 또는 왼쪽 상단 검색창에 모델 이름을 직접 입력할 수도 있습니다.
>
> ![View All](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/view_all.png)

각 모델 카드에서 **Add Model**을 클릭하여 컬렉션에 추가합니다.

![Add Model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/add_model.png)

> [!NOTE]
> 모델이 추가되면 버튼이 파란색에서 초록색 **Added**로 변경됩니다.

## 3단계: Playground 열기

1. 모델 카드에서 **Try in Playground**를 클릭합니다.  
   Playground에서는 모델을 직접 테스트하고 비교할 수 있습니다.

![Try in playground](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/try_in_playground.png)

2. GitHub 무료 모델에 접근하기 위해 GitHub 로그인이 필요합니다.  
   **Allow**를 클릭하고 이전 섹션에서 사용한 동일한 GitHub 계정으로 인증합니다.

> [!TIP]
> 로그인 후 Foundry Toolkit 확장 패널의 `GitHub` → `My Resources`에서 추가한 모델을 확인할 수 있습니다.
>
> ![Model collection](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_collection.png)
>
> 보이지 않으면 새로고침 아이콘을 클릭하세요.

3. **Model** 필드에 선택한 모델이 표시됩니다.  
   예: **Mistral Small 3.1 (via GitHub)**

![Model Playground](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_playground.png)

> [!WARNING]
> Playground 첫 실행 시 모델 초기화로 인해 로딩이 지연될 수 있습니다.

4. **Compare** 버튼을 클릭하여 비교 모드를 활성화합니다.  
5. 두 번째 모델로 **OpenAI GPT‑4o**를 선택합니다.  
6. 이제 두 모델을 나란히 비교할 준비가 되었습니다.

![Model Comparison](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_comparison.png)

## 4단계: 텍스트 및 멀티모달 기능 테스트

> [!TIP]
> 비교 모드는 동일한 입력에 대해 모델이 어떻게 다르게 응답하는지 명확히 보여주므로 모델 선택에 매우 유용합니다.

먼저 간단한 텍스트 프롬프트를 입력합니다:


1. 텍스트 입력란("Type a prompt" 표시가 있는 곳)에 다음 프롬프트를 입력합니다:

```
I'm a store manager at a DIY retailer. What are the most important metrics to review in a weekly sales summary, and why? 
```

2. 종이비행기 아이콘을 클릭하여 두 모델에서 동시에 프롬프트를 실행합니다.

![Test the model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/test_the_model.png)

> [!WARNING]
> GitHub에서 호스팅되는 무료 등급 모델 환경을 테스트하고 있으므로, 특히 더 복잡한 프롬프트의 경우 모델 응답 시간에 지연이 발생할 수 있습니다.

이제 다음 프롬프트를 사용하여 모델의 추론 능력을 테스트해 보겠습니다:

```
We have 3 stores (A, B, C). We only have 40 circuit breakers total across all stores and replenishment arrives in 10 days. 

Here's a simple snapshot of sales trend and stock on hand: 

Store 

Sales trend (WoW) 

Avg weekly units sold 

Current stock (units) 

A 

+30% 

18 

8 

B 

0% 

10 

22 

C 

-15% 

7 

10 

How should we allocate stock today to minimize stockouts and lost sales? Explain your reasoning step by step, and list the 3 most important additional data points you would ask for. 
```

다음으로, 모델의 이미지 처리 기능을 테스트해 보겠습니다:

1. 텍스트 입력란에 다음 프롬프트를 입력합니다:
```
Describe what's in this image and what kind of electrical component it appears to be. 
```

2. 이미지 첨부 아이콘을 클릭하여 입력으로 사용할 이미지를 추가합니다.

![Image Attachment](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/image_attachment.png)

3. 파일 탐색 창이 열리면 업로드할 이미지 파일을 선택하라는 메시지가 표시됩니다. 다음 경로로 이동합니다:

```
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png 
```

그런 다음 **circuit_breaker.png** 파일을 선택하고 **Open**을 클릭합니다.  
![Image File Path](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/image_file_path.png)

4. 멀티모달 프롬프트를 두 모델에 동시에 전송합니다.

## 5단계: 결과 분석 및 비교

다음과 같은 여러 요소를 기준으로 두 모델의 결과를 검토하세요:

- **응답 품질**: 설명의 깊이와 정확성, 그리고 입력 프롬프트와의 일관성을 비교합니다.

- **세부 수준**: 어떤 모델이 더 포괄적이고 심층적인 분석을 제공하나요?

- **처리 속도**: 응답 속도의 차이가 있는지 확인합니다.

- **결과 형식**: 응답의 명확성, 구성, 그리고 장황함(또는 간결함)을 평가합니다.

- **토큰 사용량**: 각 모델의 토큰 사용량을 분석하여 비용 측면의 영향을 이해합니다. 토큰 사용량은 응답의 길이뿐만 아니라 각 모델의 토크나이저 효율성에 따라서도 달라질 수 있습니다.

> [!TIP]
> 출력 토큰 수는 응답 하단의 문자 길이와 함께 표시됩니다. LLM은 비결정적(non-deterministic)이므로, 동일한 프롬프트를 여러 번 실행하더라도 토큰 사용량에 약간의 차이가 발생할 수 있습니다.  
> ![Token usage](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/token_usage.png)

### GitHub Copilot을 활용한 비교 분석

비교 분석을 보다 쉽게 수행하기 위해 GitHub Copilot을 사용하여 비교 요약을 생성할 수 있습니다.

GitHub Copilot Chat에 접속하려면 Visual Studio Code 창 상단의 **Toggle Chat** 아이콘을 선택합니다.

![Toggle chat button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/toggle-chat.png)

> [!NOTE]
> Copilot을 처음 사용할 때 로그인하라는 메시지가 표시되면 **Sign-in → Continue with GitHub**를 선택합니다.  
> 이후 GitHub 로그인 페이지로 이동하면, GitHub에서 호스팅된 모델에 접근할 때 사용한 계정으로 로그인한 뒤 **Continue**를 클릭합니다.

모델로 **Claude Sonnet 4.5**가 선택되어 있는지 확인하세요. 선택되어 있지 않다면 드롭다운 메뉴를 펼쳐 해당 모델을 선택합니다.

![Select claude Sonnet 4.5](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_claude_sonnet.png)

Copilot 채팅 창에서 다음 프롬프트를 입력해 보세요:

```
I am exploring models for an AI agent that should support Zava - a DIY retailer with 20 stores across the United States and an online channel - on store operations and head office sales analysis. I am evaluating Mistral Small 3.1 and OpenAI GPT-4o. Which one would you recommend for this scenario, and why? Explain the trade-offs between models (e.g., reasoning ability, cost, latency, context length) so that I can make an informed choice. 
```

이에 대해 Copilot은 Foundry Toolkit의 **Get AI Model Guidance** 도구를 호출하여, 사용 사례에 기반한 모델 추천을 제공합니다.  
응답에는 도구 호출 세부 정보가 포함된 확장 가능한 섹션과 함께 비교 분석 결과가 표시됩니다.

![Get AI model guidance](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/get_ai_model_guidance.png)

> [!NOTE]
> GitHub Copilot이 응답 생성 시 Foundry Toolkit 도구를 자동으로 호출하지 않는 경우, 채팅 창에 `#aitk`를 입력하여 사용하려는 도구를 명시적으로 선택한 후 프롬프트를 전송할 수 있습니다.

## 6단계: Microsoft Foundry에서 선택한 모델 가져오기

모델 비교가 끝나면, 다음 실습 단계에서 추가 프로토타이핑에 사용할 모델을 하나 선택합니다.  
이 실습에서는 **GPT-4o**를 사용하겠습니다.

> [!NOTE]
> 기본 Playground(단일 패널, 단일 모델 보기)로 돌아가려면 모델 이름 오른쪽의 **Select this model**을 클릭합니다.
>
> ![Select this model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_this_model.png)

다음 단계에서는 DIY 소매 기업인 Zava와 관련된 추가 컨텍스트 데이터를 모델에 제공할 예정이므로, 엔터프라이즈 수준의 보안 및 규정 준수 기능을 제공하는 Microsoft Foundry 호스팅 모델로 전환해야 합니다.

**Model Playground**로 돌아가서 **Model** 드롭다운 메뉴를 확장한 뒤, 이전 실습 섹션(./01_Get_Started.md)에서 로그인했던 프로젝트에 사전 배포된 Microsoft Foundry 호스팅 gpt-4o 인스턴스를 선택합니다.

![Select Azure Model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_azure_model.png)

> [!NOTE]
> GitHub 호스팅 모델은 프로토타이핑에 매우 적합하지만, Microsoft Foundry에서 호스팅되는 모델은 프로덕션 배포에 필요한 엔터프라이즈 기능을 제공합니다. 여기에는 엔터프라이즈 수준의 보안 및 규정 준수, SLA(Service Level Agreements), 향상된 성능 및 확장성, 그리고 다른 Azure 서비스와의 통합이 포함됩니다.

## 주요 정리

- Model Catalog는 여러 제공업체의 AI 모델을 한눈에 볼 수 있는 종합적인 뷰를 제공합니다.

- 필터링 기능을 통해 요구 사항에 맞는 모델을 빠르게 식별할 수 있습니다.

- Playground에서의 모델 비교는 데이터 기반 의사 결정을 가능하게 합니다.

- 다양한 호스팅 옵션은 개발 단계에 따라 서로 다른 이점을 제공합니다.

- 내장된 비교 도구를 활용하면 멀티모달 기능도 효과적으로 테스트할 수 있습니다.

이와 같은 탐색 과정을 통해 성능, 비용, 기능, 구현 요구 사항 등을 균형 있게 고려하여 특정 사용 사례에 가장 적합한 모델을 선택할 수 있습니다.

다음 실습 단계로 진행하려면 **Next**를 클릭하세요.

===

# 모델 보강: 성능 향상을 위한 컨텍스트 강화

이 섹션에서는 선택한 모델의 성능과 특정 사용 사례에 대한 적합성을 높이기 위해 프롬프트 엔지니어링과 컨텍스트 데이터를 활용하는 방법을 학습합니다. 이는 AI 모델을 비즈니스 시나리오의 고유한 요구 사항에 맞게 조정하는 데 있어 매우 중요한 단계입니다.

## 1단계: 시스템 메시지 설계

시스템 메시지는 AI 모델의 동작과 맥락을 정의하는 프롬프트의 핵심 구성 요소입니다. 이를 통해 모델은 자신의 역할과 수행해야 할 작업의 구체적인 요구 사항을 이해하게 됩니다. 효과적인 시스템 메시지를 작성하기 위한 주요 고려 사항은 다음과 같습니다:

1. 명확하고 간결하게 작성하세요: 상호작용의 목적과 기대하는 결과를 분명히 설명합니다. 모호함을 피하여 모델이 작업을 정확히 이해하도록 합니다.  
2. 충분한 맥락을 제공하세요: 모델이 보다 정확하고 맥락에 맞는 답변을 생성할 수 있도록 관련 배경 정보를 포함합니다.  
3. 기대 사항을 명시하세요: 응답의 형식, 길이, 스타일 등 필요한 제약 조건이나 요구 사항을 구체적으로 지정합니다.  
4. 복잡한 지시는 나누어 작성하세요: 작업이 복잡하다면, 단계별로 나누어 간단한 지침으로 제공하여 모델이 효과적으로 따를 수 있도록 합니다.  

Playground 오른쪽 패널의 **System Prompt** 입력란에 다음 시스템 메시지를 입력하세요:

```
You are Cora, an internal assistant for Zava (a DIY retailer). You help store managers and head office staff analyze sales and manage inventory. 

Your role is to: 

- Ask clarifying questions to understand the reporting or inventory request. 
- Provide concise, actionable summaries and recommendations. 
- Be careful with operational actions: if asked to move inventory, you must ask for explicit confirmation first. 
- Be brief in your responses. 

Your personality is: 

- Professional, precise, and helpful 
- Curious and practical-never assume, always clarify 

Stick to Zava store operations, sales analysis, and inventory topics. If asked something outside of that, politely say you can only assist with Zava-related operational requests. 
```

![System Prompt](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/system_prompt.png)

이 시스템 메시지에는 다음이 포함되어 있습니다:

- 어시스턴트의 역할과 책임에 대한 명확한 정의(매장 운영 + 본사 영업 분석)  
- 응답 방식에 대한 구체적인 지침(간결하고 실행 가능하며, 먼저 명확히 질문하기)  
- 운영 작업에 대한 안전 장치(재고 이동 전 반드시 명시적 확인 요청)  

## 2단계: 멀티모달 입력으로 시스템 메시지 테스트

이제 시스템 프롬프트를 설정했으므로, 멀티모달 사용자 프롬프트로 시스템을 테스트해 보겠습니다. Playground 채팅에서 이미지 첨부 아이콘을 클릭하여 대화 맥락에 이미지를 업로드합니다. 그런 다음 아래 경로에 있는 차단기 이미지를 선택합니다:

```
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png 
```

다음 사용자 프롬프트와 함께 사용하세요:

```
Here is a photo from the store. What is this component and what details should I capture (e.g., amperage, pole type) before searching our catalog and checking stock? 
```

모델은 이미지를 분석하고, 해당 구성 요소에 대한 설명과 함께 카탈로그 검색 및 재고 확인 전에 수집해야 할 세부 정보를 제안합니다. 응답이 시스템 메시지에서 정의한 기대 사항과 일치하는지 확인해 보세요.

이제 Zava 비즈니스와 관련이 없는 사용자 질문으로 모델을 테스트해 보겠습니다. 다음 프롬프트를 입력하세요:

```
What's the weather like in San Francisco today?  
```

모델은 Zava 관련 운영 요청에 대해서만 도움을 줄 수 있다고 정중하게 안내해야 하며, 이는 시스템 메시지의 지침을 제대로 따르고 있음을 보여줍니다.

## 3단계: 그라운딩 데이터 추가

시스템 메시지 외에도, 컨텍스트 데이터를 제공하면 모델이 보다 관련성 높고 정확한 답변을 생성하는 데 큰 도움이 됩니다. 이러한 데이터에는 비즈니스, 제품, 서비스 또는 기타 관련 정보가 포함될 수 있으며, 모델이 시나리오를 더 잘 이해하도록 돕습니다.

이번 사용 사례에서는 Zava의 제품 카탈로그에 대한 일부 정보를 모델에 제공하여, 내부 질문에 답할 때 제품 세부 정보를 임의로 생성하지 않도록 하겠습니다.

그라운딩 데이터를 추가하기 위해 Playground의 **파일 첨부 기능**을 사용합니다. 이를 통해 모델이 응답 생성 시 참고할 수 있는 문서를 업로드할 수 있습니다.

업로드할 문서는 Zava 제품 카탈로그의 일부를 포함한 JSON 파일입니다. 내용을 확인하려면 `/data/` 폴더로 이동하여 `zava_product_catalog.json` 파일을 찾아 코드 편집기에서 열어보세요.

1. 프롬프트 입력 영역에서 파일 첨부 아이콘을 클릭합니다.  
![File attachment icon](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/file_attachment_icon.png)

2. `/data/` 디렉터리에서 `zava_product_catalog.json` 파일을 선택합니다.

> [!TIP]
> 열리는 창에서 다음 경로를 통해 데이터 디렉터리를 찾을 수 있습니다:
> ```
> C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\data
> ```

![Uploading Grounding Data File](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/uploading_grounding_data_file.png)

3. 파일이 업로드되면 프롬프트 입력 영역 아래에 첨부 파일로 표시됩니다.

4. 텍스트 입력란에 다음 프롬프트를 입력합니다:

```
From the attached Zava product catalog, suggest a circuit breaker option that would commonly be used for a 15-amp home circuit, and explain what you would check before recommending it.
```

모델은 업로드된 제품 카탈로그를 분석하고, 요청에 적합한 차단기 옵션을 근거와 함께 제안합니다.

내부적으로는 첨부된 데이터가 자동으로 프롬프트 컨텍스트에 포함되어, 모델이 보다 정보에 기반한 관련성 높은 응답을 생성할 수 있도록 합니다.

물론 이 접근 방식에는 한계가 있습니다. 모델은 프롬프트 컨텍스트에서 처리할 수 있는 텍스트 양에 제한이 있으며, 첨부되는 컨텍스트가 많을수록 응답 지연 시간과 비용이 증가합니다. 더 큰 데이터 세트나 복잡한 시나리오의 경우, 현재 사용자 질의와 가장 관련성 높은 정보만 프롬프트에 포함되도록 보다 정교한 검색(리트리벌) 메커니즘을 구현해야 합니다. 이에 대해서는 다음 섹션에서 더 자세히 살펴보겠습니다.

### 주요 정리

- 효과적인 시스템 메시지를 설계하는 것은 모델의 동작을 유도하고 관련성 높은 응답을 보장하는 데 핵심적입니다.  

- 파일 첨부를 통한 컨텍스트 데이터 제공은 모델의 성능과 관련성을 크게 향상시킬 수 있습니다.  

- 멀티모달 입력 테스트는 시스템 메시지와 컨텍스트 데이터의 효과를 검증하는 데 도움이 됩니다.  

- 그라운딩 데이터는 모델의 입력 제한에 맞도록 관련성 있고 간결하게 유지해야 합니다.  

다음 실습 섹션으로 진행하려면 **Next**를 클릭하세요.
 
===

# 에이전트 구축: Agent Builder를 사용하여 Zava 매장 운영 에이전트 Cora 만들기

이 섹션에서는 Foundry Toolkit의 Agent Builder를 사용하여 Cora 에이전트를 생성하고, 사용자 대신 작업을 수행할 수 있도록 도구를 연결하는 방법을 학습합니다.  
Agent Builder는 프롬프트 엔지니어링과 MCP 서버 같은 도구 통합을 포함하여 에이전트 구축을 위한 엔지니어링 워크플로를 간소화합니다.

## 1단계: Agent Builder 살펴보기

Foundry Toolkit 화면에서 **Agent Builder**를 선택하여 접속합니다.

![Agent Builder](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/agent-builder.png)

Agent Builder 인터페이스는 두 개의 영역으로 구성되어 있습니다.  
왼쪽 영역에서는 에이전트의 기본 정보(이름, 모델 선택, 지침, 연결할 도구 등)를 설정할 수 있습니다.  
오른쪽 영역에서는 에이전트와 직접 대화하며 응답을 테스트하고 평가할 수 있습니다.

> [!NOTE]
> 평가 기능은 에이전트 지침(Instructions)에 변수를 정의한 이후에만 사용할 수 있습니다. 평가는 본 실습의 보너스 섹션에서 더 자세히 다룹니다.

---

## 2단계: 에이전트 생성

이제 Zava의 Cora 에이전트를 생성해 보겠습니다.  

**Agent Builder**에서 **+ New Agent**를 선택합니다.  
**Agent name** 필드에 **Cora**를 입력합니다.  
**Model**은 **gpt-4o (via Microsoft Foundry)** 인스턴스를 선택합니다.

![Agent Basic Information](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/agent-basic-information.png)

---

## 3단계: 에이전트 지침 설정

앞서 Model Playground에서 수행한 것과 유사하게, 이제 시스템 프롬프트를 통해 에이전트의 동작을 정의합니다.

> [!TIP]
> Agent Builder에는 작업 설명을 기반으로 LLM이 자동으로 지침을 생성해 주는 **Generate** 기능이 있습니다.  
> 에이전트 지침 작성이 어려운 경우 유용하게 활용할 수 있습니다.  
> ![Generate Agent Instruction](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/generate-agent-instruction.png)

이번 실습에서는 [previous section](./03_Model_Augmentation.md)에서 사용한 것과 유사한 지침을 사용합니다:

```
# **Zava 영업 및 재고 에이전트 - 시스템 지침**

## 1. 역할 및 컨텍스트

당신은 **Zava**(DIY 소매업체)의 내부 어시스턴트 **Cora**입니다.  
매장 관리자 및 본사 직원의 매출 분석과 재고 관리를 지원합니다.

* **톤:** 전문적이고, 정확하며, 도움이 되는 방식.

* **회계연도(FY):** 매년 **7월 1일** 시작  
  * Q1: 7-9월 | Q2: 10-12월 | Q3: 1-3월 | Q4: 4-6월

* **날짜 처리:** "지난달", "Q1"과 같은 상대 날짜는 항상 ISO 형식(YYYY-MM-DD)으로 변환하여 데이터베이스 질의에 사용합니다.

---

## 2. 도구 사용 전략 (라우터)

사용자의 의도를 분석하여 적절한 도구 흐름을 선택해야 합니다.

### A. 제품 탐색 (정성적 요청)

* **트리거:** 제품 특징, 설명, 용도, 모호한 이름 요청 (예: "방수 조명", "콘크리트용 드릴")
* **행동:** 반드시 `semantic_search_products`를 먼저 사용합니다.
* **제한:** 제품 설명이나 이름 검색에 SQL을 **절대 사용하지 마세요.**

---

### B. 매출 및 데이터 분석 (정량적 요청)

* **트리거:** 매출, 판매 수량, 상위 매장, 집계 지표 요청
* **행동:** `execute_sales_query` 사용
* **요구사항:** 시간 관련 질의일 경우(예: "지난달 매출") 반드시 먼저 `get_current_utc_date`를 호출하여 정확한 날짜 범위를 계산해야 합니다.

---

### C. 재고 및 작업 (읽기/쓰기)

* **트리거:** 재고 수준 조회 또는 재고 이동 요청

* **워크플로:**

  1. **식별:** 제품 ID를 모를 경우 `semantic_search_products` 사용
  2. **확인:** `get_stock_level_by_product_id`로 재고 및 내부 store_id 확인
  3. **확인 요청 (중요):**  
     재고 이전 요청 시 반드시 중단 후 다음과 같이 확인:
     > "확인 부탁드립니다: [제품명] [수량]개를 [매장 A]에서 [매장 B]로 이동하시겠습니까?"
  4. **실행:** 사용자 명시적 확인 후에만 `transfer_stock` 호출

---

## 3. 콘텐츠 제한 및 보안

* **쓰기 보호:** 현재 대화 턴에서 명시적 사용자 확인 없이 `transfer_stock` 실행 금지
* **ID 비공개:** 내부적으로 store_id, product_id 사용 가능하나, 최종 사용자 응답에는 절대 노출 금지
* **환각 금지:** 도구가 데이터를 반환하지 않으면  
  > "해당 요청에 해당하는 데이터를 찾을 수 없습니다."  
  라고 응답하고 임의 생성 금지
* **범위 외 요청:**
  > "Zava의 매출, 재고 및 제품 데이터 관련 업무만 지원할 수 있습니다. 기타 주제는 IT 지원팀에 문의해 주세요."

---

## 4. 응답 가이드라인

* **형식:** 제품 목록 또는 매출 데이터는 Markdown 표 형식 사용
* **결과 없음 처리:**
  * 의미 검색 실패 시:  
    > "해당 설명과 일치하는 제품을 찾을 수 없습니다."
  * 매출 데이터 없음:  
    > "해당 조건에 대한 매출 기록이 없습니다."
* **언어:** 사용자 언어로 응답
* **모호성 처리:** 명확하지 않으면 추측하지 말고 질문

---

## 5. 예시 질문 (최대 10개 제안)

* 지난달 가장 많이 팔린 카테고리는 무엇인가요? (온라인 vs 오프라인)
* 2024년 2분기 총 매출은 얼마인가요?
* 현재 차단기 재고가 부족한 매장은 어디인가요?
* "Pro-Series Hammer Drill" 재고를 전 매장에서 확인해 주세요
* 이번 달 미국 전체 매장에서 매출 상위 10개 제품은 무엇인가요?
* 한 매장에서 다른 매장으로 "Pro-Series Hammer Drill" 5개 이동
* 지난달 온라인 카테고리별 매출은?
* 전월 대비 반품이 비정상적으로 높은 매장은?

---

## 6. 구현 시 참고 사항

* **작업 순서:** 날짜 확인 → 검색/질의 → 형식화
* **제한:** 모든 SQL 질의는 기본 `LIMIT 20`
* **모호한 검색 결과:** 유사도 점수가 낮을 경우 다음 문구로 시작:
  > "검색 결과 가장 가능성이 높은 제품 후보는 다음과 같습니다."
```

이처럼 매장 운영(매출 분석, 재고 확인, 안전한 재고 이동)에 대한 명확한 지침을 추가했습니다.  
하지만 아직 Cora에게 실제 매출 및 재고 데이터 접근 권한은 제공하지 않았습니다. 다음 단계에서 설정하겠습니다.

---

## 4단계: MCP 서버 시작

> [!NOTE]  
> [Model Context Protocol (MCP)](https://modelcontextprotocol.io/docs/getting-started/intro)는 LLM과 외부 도구, 애플리케이션, 데이터 소스 간의 통신을 표준화하는 강력한 프레임워크입니다.

이전 "모델 보강" 실습에서는 파일 첨부를 통해 정적 데이터를 제공했습니다.  
하지만 실제 매장 운영에는 실시간으로 변하는 매출 및 재고 데이터가 필요합니다.

이를 위해 다음 두 개의 MCP 서버를 Cora에 연결합니다:

* **Sales Analysis MCP server** (매출 지표 + 제품 의미 검색)
* **Inventory MCP server** (재고 조회 + 안전한 재고 이전)

Visual Studio Code에서 **F5를 눌러 MCP 서버를 시작**하고, 두 서버가 모두 초기화될 때까지 기다립니다.  
각 서버마다 새로운 터미널 창이 열리며, `Uvicorn is running on port XXXX` 메시지가 표시되면 정상 실행 중입니다.

![MCP Servers running](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/mcp_servers_running.png)

> [!TIP]
> VS Code의 **Run and Debug** 탭에서 상단의 초록색 실행 버튼을 눌러 시작할 수도 있습니다.

그 후 `./.vscode/mcp.json` 파일로 이동하여 각 Zava MCP 서버 이름 위의 *Start* 버튼을 클릭합니다.

> [!WARNING]
> GitHub Copilot Chat을 이전에 사용했다면 **Restart** 버튼이 표시될 수 있습니다. 이 경우 Restart를 클릭하여 Foundry Toolkit이 이미 실행 중인 MCP 서버에 연결하도록 하세요.

---

## 5단계: 매출 MCP 도구를 에이전트에 추가

Agent Builder로 돌아가서 **TOOL** 옆의 **+** 아이콘을 선택합니다.

**MCP Server → Use Tools Added in Visual Studio Code**를 선택합니다.

**Edit Tool List**를 클릭한 뒤 다음 네 가지 도구를 선택합니다:

- `mcp_zava-sales-an_semantic_search_products`
- `mcp_zava-sales-an_execute_sales_query`
- `mcp_zava-sales-an_get_database_schema`
- `mcp_zava-sales-an_get_current_utc_date`

**OK**를 클릭합니다.

> [!NOTE]
> Sales Analysis MCP 서버가 실행 중이어야 도구 목록에 표시됩니다.

---

## 6단계: 에이전트로 매출 질의 테스트

Agent Builder 오른쪽 채팅 패널에서 차단기 이미지를 첨부한 뒤 다음 프롬프트를 입력합니다:

```
I'm the store manager. Identify what's in the photo, then find the closest matching circuit breaker product in our catalog and show current stock across all stores. 
```

도구 호출이 필요하면 VS Code에서 실행 승인 메시지가 나타납니다. 각 호출에 대해 **Yes**를 선택합니다.

모델은 비결정적이므로 응답은 매번 달라질 수 있습니다.

이후 다음 질문도 테스트해 보세요:

```
What were the sales by store for the last quarter
```

```
What are our top 3 selling products last year
```

---

## 7단계: 재고 MCP 도구 추가

Agent Builder에서 다시 **Tools → + → MCP Server → Use Tools Added in Visual Studio Code**를 선택합니다.

상단 체크박스를 해제하여 전체 선택 해제 후:

1. 검색창에 **invent** 입력
2. 다음 두 도구 선택:
   - `mcp_zava-inventor_get_stock_level_by_product_id`
   - `mcp_zava-inventor_transfer_stock`
3. **OK** 클릭

> [!NOTE]
> Inventory MCP 서버가 실행 중이어야 합니다.

---

## 8단계: 재고 확인 및 이전 테스트

다음과 같은 요청으로 테스트해 보세요:

```
Transfer 5 units of the Single Pole Circuit Breaker 20A from a store with surplus stock to the online store.
```

에이전트는 반드시 이전 실행 전에 확인을 요청해야 합니다.  
확인 후, 재고 수준을 다시 조회하여 이전이 성공했는지 검증하세요.

추가 테스트 예시:

```
What was the total revenue last month, split by online vs physical stores?
```

```
Which stores have low stock on circuit breakers right now?
```

---

## 주요 정리

- Agent Builder는 설정과 테스트를 분리한 2패널 인터페이스를 제공합니다.
- 명확한 지침은 에이전트의 성격, 대화 스타일, 응답 패턴을 일관되게 만듭니다.
- MCP 서버는 정적 파일 첨부보다 더 효과적으로 외부 데이터와 도구를 연결합니다.
- MCP 도구 통합을 통해 에이전트는 실시간 매출·재고 조회 및 명시적 확인 기반의 운영 작업 수행이 가능합니다.

다음 섹션으로 진행하려면 **Next**를 클릭하세요.

===

# 코드로 마이그레이션

이 섹션에서는 Foundry Toolkit에서 생성한 에이전트를 코드 기반 워크플로로 마이그레이션하는 방법을 학습합니다.

Foundry Toolkit은 Agent Builder에서 생성한 에이전트에 대해 자동으로 코드를 생성해 줍니다. 원하는 SDK와 프로그래밍 언어를 선택할 수 있으며, 생성된 코드 파일을 자신의 애플리케이션에 통합할 수 있습니다.

---

## 1단계: 코드 생성

Agent Builder 화면의 왼쪽 하단으로 스크롤하여 **View Code**를 선택합니다.

![View code button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/view-code.png)

SDK(예: *Microsoft Agent Framework*)와 프로그래밍 언어(예: *Python*)를 선택하라는 메시지가 표시되면 원하는 옵션을 선택합니다.  

새 파일이 생성되면 작업 공간에 저장합니다. (`src/cora-app.py`)

---

## 2단계: 코드 검토

스크립트를 실행하기 전에 파일 내용을 검토하세요. 실행 전에 수정이 필요한 플레이스홀더가 포함되어 있을 수 있습니다.  

스크립트의 로직을 이해하는 데 도움이 필요하다면 GitHub Copilot Chat의 **Ask** 모드를 사용할 수 있습니다.

Visual Studio Code 상단의 **Toggle Chat** 아이콘을 선택하여 GitHub Copilot Chat에 접속합니다.

![Toggle chat button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/toggle-chat.png)

> [!NOTE]
> Copilot을 처음 사용할 때 로그인하라는 메시지가 표시되면 **Sign-in → Continue with GitHub**를 선택하세요.  
> 이후 GitHub 로그인 페이지로 이동하면, GitHub에서 호스팅된 모델에 접근할 때 사용한 GitHub Enterprise 계정으로 로그인한 뒤 **Continue**를 클릭합니다.

생성된 코드 파일을 `src/cora-app.py`로 저장하고, GitHub Copilot Chat이 해당 파일을 컨텍스트로 사용할 수 있도록 파일을 활성 상태로 유지하세요.  
또는 Copilot Chat 프롬프트에서 파일명을 직접 참조할 수도 있습니다.

![GitHub Copilot Chat in Ask mode.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/ghcp-ask-mode.png)

> [!NOTE]
> 파일 이름 옆에 '+' 아이콘이 보인다면, Copilot이 해당 파일을 컨텍스트로 제안했지만 아직 추가되지 않은 상태입니다. '+' 아이콘을 클릭하여 파일을 컨텍스트에 추가하세요.
>
> ![Suggested file as context](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/suggested_file_context.png)

예를 들어, 다음과 같은 프롬프트를 입력해 볼 수 있습니다:

```
Explain what's happening in this script.
```

코드를 수정해야 할 경우, **Agent** 모드로 전환하여 변경을 요청할 수 있습니다.  
파일이 수정되기 전에 변경 사항에 대한 승인을 요청받게 됩니다.

---

## (선택 사항) 보너스

코드를 실제로 실행하려면 파일을 저장한 후, 파일 상단의 주석에 포함된 안내를 따르세요.  
선택한 SDK와 프로그래밍 언어에 따라 절차가 달라질 수 있습니다.

예를 들어, **Microsoft Agent Framework** SDK와 **Python**을 선택한 경우 다음 단계를 따르세요:

### 1. MCP 서버 도구 설정 부분 찾기

코드 파일에서 MCP 서버 도구를 설정하는 부분을 찾습니다. 다음과 유사한 코드가 있을 것입니다:

```python
MCPStdioTool(

    name="VSCode Tools".replace("-", "_"),

    description="MCP server for VSCode Tools",

    command="INSERT_COMMAND_HERE",

    args=[

        "INSERT_ARGUMENTS_HERE",

    ]

),
```

### 2. 플레이스홀더 수정

위의 플레이스홀더를 본 워크숍에서 사용한 두 개의 MCP 서버(매출 분석 및 재고 관리)를 가리키도록 수정합니다.

본 워크숍에서는 다음 로컬 주소에서 서버가 실행됩니다:

- `http://localhost:8004/mcp/` (Sales Analysis MCP server)
- `http://localhost:8005/mcp/` (Inventory MCP server)

수정된 구성 예시는 다음과 같습니다:

```python
MCPStreamableHTTPTool(

    name="sales_analysis",

    description="MCP server for Sales Analysis",

    url="http://localhost:8004/mcp/"

),
MCPStreamableHTTPTool(

    name="inventory_management",

    description="MCP server for Inventory Management",

    url="http://localhost:8005/mcp/"

)
```

> [!NOTE]
> 선택한 SDK에 따라 로컬 stdio 프로세스 대신 HTTP MCP 서버 URL로 구성해야 할 수도 있습니다.

---

### 3. 새 터미널 열기

Visual Studio Code 상단 메뉴에서 **Terminal → New Terminal**을 선택하여 새 터미널을 엽니다.

### 4. 필요한 의존성 설치

```
pip install agent-framework --pre
```

### 5. Azure 인증

```
az login
```

브라우저 창이 열리면 인증 코드를 입력하여 로그인 과정을 완료합니다.  
터미널로 돌아온 후 Enter 키를 눌러 Azure 구독 선택을 확인합니다.

코드 파일이 저장된 디렉터리로 이동합니다:

```
cd src
```

다음 명령어로 스크립트를 실행합니다:

```
python cora-app.py
```

> [!NOTE]
> 스크립트를 실행하기 전에 MCP 서버가 실행 중인지 확인하세요.  
> 이전 단계를 정상적으로 수행했다면, MCP 서버는 이미 로컬 환경에서 실행 중이어야 합니다.

GitHub Copilot Chat의 **Agent 모드**를 사용하여 Cora 에이전트의 인터페이스 파일 생성을 지원받을 수 있습니다.  
또한 Copilot에 에이전트 스크립트를 앱 인터페이스와 통합해 달라고 요청하여 기능하는 에이전트 프로토타입을 구축할 수도 있습니다.

---

## 주요 정리

- Agent Builder는 다양한 프로그래밍 언어 및 SDK에 대한 에이전트 코드를 자동 생성하여, 프로토타입에서 프로덕션 환경으로의 전환을 간소화합니다.

- 생성된 코드에는 실행 전에 수정이 필요한 플레이스홀더가 포함될 수 있으므로, 개발자는 이를 이해하고 요구 사항에 맞게 조정해야 합니다.

- GitHub Copilot Chat의 Ask 및 Agent 모드를 활용하면 생성된 코드를 이해하고, UI 구성 요소 등 추가적인 애플리케이션 요소를 빠르게 구현할 수 있습니다.

다음 실습 단계로 진행하려면 **Next**를 클릭하세요.
 

===

# 보너스: 에이전트 응답 수동 평가하기

> [!NOTE]
> 이 섹션은 실습 시간에 여유가 있을 경우 진행할 수 있는 보너스 섹션입니다. 시간이 부족하다면 집에 돌아가서 자신의 속도에 맞게 완료하셔도 됩니다.

이 섹션에서는 에이전트의 응답 데이터 세트를 **수동으로 평가**하는 방법을 학습합니다. 수동 평가는 사람이 직접 LLM의 출력 품질을 판단하는 방식입니다. 실제로는 생성된 응답을 읽고, 루브릭이나 간단한 기준에 따라 정확성, 관련성, 명확성 또는 전반적인 품질("좋음"/"나쁨")을 평가합니다. Agent Builder를 사용하면 이러한 수동 평가를 통해 에이전트의 성능을 점검할 수 있습니다.

---

## 1단계: 에이전트 지침에 변수 추가하기

Agent Builder의 **Evaluation** 기능을 사용하려면 에이전트의 **Instructions**에 변수가 포함되어 있어야 합니다.  
변수는 에이전트 지침이나 사용자 프롬프트의 맥락을 변경할 수 있는 값이며, 에이전트의 전체 목적과 관련이 있어야 합니다. 변수는 중괄호 두 쌍으로 감싸서 표시합니다 (예: `{{변수}}`).

Cora 에이전트의 목적은 매장 운영과 본사 보고를 지원하는 것이므로, 운영 맥락을 변경하는 변수를 사용하는 것이 적절합니다. 이 예제에서는 `{{store}}` 변수를 사용합니다.  

**Instructions**를 다음과 같이 수정합니다:

```
You are Cora, Zava's internal assistant. You help store managers and head office staff analyze sales and manage inventory, tailored to the needs of the {{store}} location.

Your role is:

- Ask clarifying questions and be concise in your responses.

- Use Zava tools (sales + inventory) to answer questions with facts whenever possible.

- Summarize sales performance, answer inventory questions, and recommend next actions for the {{store}} location.

Your personality is:

- Professional, accurate, and helpful

- Curious and practical - never assume, always clarify
```

> [!NOTE]
> 모델이 gpt-4o (via Microsoft Foundry)로 설정되어 있는지 확인하세요.

모든 변수는 Agent Builder의 **Variables** 섹션에 저장됩니다. 아래 스크린샷에 오류 메시지가 표시되더라도 무시하세요. 변수 값은 Evaluation 탭에서 전달하게 됩니다.

![Agent variables.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/agent-variables.png)

이 기능은 어떻게 작동할까요?

예를 들어 `{{store}}` 값으로 `Seattle`을 설정했다고 가정해 보겠습니다.  
사용자 프롬프트가 실행될 때, **Instructions**는 동적으로 수정되어 `{{store}}` 자리에 `Seattle`이 반영됩니다.

예시:

> "You are Cora, Zava's internal assistant. You help store managers and head office staff analyze sales and manage inventory, tailored to the needs of the Seattle location."

이제 평가 데이터를 실행해 보면서 실제로 확인해 보겠습니다.

---

## 2단계: 데이터 추가

Agent Builder에서 **Evaluation** 탭으로 이동합니다.  
평가를 실행하려면 **User Query**와 **{{store}}** 값이 모두 필요합니다.

- **User Query**: 사용자가 에이전트에 보내는 프롬프트  
- **{{store}}**: 변수에 전달할 값  

> [!NOTE]
> `+ Add an Empty Row`를 클릭해야만 `{{store}}` 변수가 테이블 헤더에 표시됩니다.

![Evaluation table.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/evaluation-table.png)

데이터를 추가하는 방법에는 여러 가지가 있습니다.

> [!TIP]
> Evaluation 섹션을 확장하려면 휴지통 아이콘 옆의 **Expand to Full Screen** 아이콘을 클릭하세요.

---

### 1) 수동으로 데이터 추가

**Evaluation** 탭에서 빈 행을 추가한 후, **User Query**와 `{{store}}` 셀에 직접 입력할 수 있습니다.

예시:

User Query  
{{store}}

지난달 매출 기준 상위 3개 카테고리는 무엇인가요?  
Seattle  

이번 주에 재고 부족 위험이 있는 제품은 무엇인가요?  
Redmond  

지난달 온라인 매출과 오프라인 매출 성과를 요약해 주세요.  
Head Office  

이번 주말 프로모션을 위한 차단기 재고는 충분한가요?  
Bellevue  

> [!TIP]
> **Add an Empty Row** 버튼으로 행을 추가한 뒤, 셀을 더블 클릭하여 편집하세요.

---

### 2) 데이터 생성 (Generate Data)

데이터 생성이 필요하다면 **Generate Data** 기능을 사용하여 최대 10개의 합성 데이터를 생성할 수 있습니다.  

합성 데이터는 실제 데이터를 모방하여 인위적으로 생성된 데이터입니다.  
이 기능은 Generation Logic을 입력받아 **User Query**와 `{{store}}` 쌍을 생성하는 LLM을 사용합니다.

기본적으로 에이전트의 Instructions를 기반으로 Generation Logic이 자동 생성되지만, 필요에 따라 수정할 수 있습니다.

![Generate data.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/generate-data.png)

**Rows of Data to Generate** 값을 입력한 뒤 **Generation Logic**을 수정하고 **Generate**를 클릭하면 데이터 세트가 생성되어 평가 테이블에 표시됩니다.

---

### 3) 데이터 세트 가져오기 (Import)

대량의 **User Query** 및 `{{store}}` 쌍을 직접 생성한 경우, CSV 파일로 Agent Builder에 업로드할 수 있습니다.

CSV 파일 형식:

User Query  
{{store}}

지난달 매출 기준 상위 3개 카테고리는 무엇인가요?  
Seattle  

이번 주에 재고 부족 위험이 있는 제품은 무엇인가요?  
Redmond  

지난달 온라인 매출과 오프라인 매출 성과를 요약해 주세요.  
Head Office  

이번 주말 프로모션을 위한 차단기 재고는 충분한가요?  
Bellevue  

**User Query**와 `{{store}}`는 반드시 헤더여야 합니다.

**Import** 아이콘(위쪽 화살표 모양)을 클릭하여 CSV 파일을 업로드할 수 있습니다.

![Import dataset.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/import-dataset.png)

각 옵션을 직접 시도해 보세요!  
이후 실습은 **수동 데이터 추가** 방식을 기준으로 진행됩니다.

---

## 3단계: 에이전트 성능 평가

데이터 세트가 준비되면, 각 행을 개별 실행하거나 여러 행을 동시에 실행할 수 있습니다.  

모든 행을 선택하려면 헤더 행의 체크박스를 선택하세요.  
선택한 행을 실행하려면 **Run Response** 아이콘(Play 버튼)을 클릭합니다.

![Run button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/run-eval.png)

모델은 각 **User Query**와 `{{store}}` 조합에 대해 응답을 생성합니다.  
응답이 생성되면 결과를 검토한 후 **Manual** 열에서 👍 또는 👎 아이콘을 선택합니다.

![Manual evaluation.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/manual-evaluation.png)

어떻게 판단해야 할까요?

- 👍 **Thumbs Up**: 응답이 정확하고, 관련성이 높으며, 명확하고, 실제로 도움이 되었을 때  
- 👎 **Thumbs Down**: 응답이 부정확하거나, 불완전하거나, 혼란스럽거나, 주제와 맞지 않거나, 도움이 되지 않았을 때  

간단히 말해 스스로에게 이렇게 질문하세요:

**"이 결과가 내가 필요로 한 것을 충족했는가?"**  
→ 그렇다면 👍, 아니라면 👎를 선택하세요.

---

## 주요 정리

- `{{store}}`와 같은 변수를 추가하면, 에이전트의 핵심 목적을 유지하면서 다양한 운영 맥락에서 체계적인 테스트가 가능합니다.

- Agent Builder는 수동 입력, 합성 데이터 생성, CSV 가져오기를 모두 지원하여 유연한 평가 데이터 세트 구성이 가능합니다.

- 👍/👎 기반의 인간 평가를 통해 자동화된 지표를 넘어 정확성, 관련성, 유용성을 종합적으로 판단할 수 있습니다.

---

# 요약

이 실습에서 다음을 학습했습니다:

- 비즈니스 시나리오에 적합한 모델을 탐색하고 비교하는 방법  
- 더 정확하고 근거 있는 응답을 얻기 위해 프롬프트와 데이터를 활용하는 방법  
- MCP(Model Context Protocol)를 통해 모델과 도구를 결합하여 내부용 에이전트를 프로토타이핑하는 방법  
- 추가 커스터마이징 및 구현을 위해 에이전트 코드를 추출하는 방법  

또한 Visual Studio Code의 Foundry Toolkit을 활용하여 AI 기반 애플리케이션을 효율적으로 개발하는 실습 경험을 쌓았습니다.

---

## 다음 단계

AI 에이전트를 프로덕션 환경에 배포하기 전에 다음 사항을 고려하세요:

- **Azure에서 호스팅되는 모델:**  
  프로덕션 환경에서는 Azure에서 호스팅되는 모델 사용을 권장합니다. 더 나은 성능, 안정성 및 엔터프라이즈 수준의 규정 준수를 제공합니다.  
  Microsoft Foundry Models 카탈로그에서 확인할 수 있습니다:  
  https://ai.azure.com/catalog  

- **평가:**  
  에이전트를 배포하기 전에 정확성, 관련성, 안전성 측면에서 충분히 평가하세요. 자동화 테스트와 인간 평가를 병행하는 것이 좋습니다.  
  관련 문서:  
  https://code.visualstudio.com/docs/intelligentapps/evaluation  

- **배포:**  
  Microsoft Agent Framework 기반 Python 애플리케이션, Microsoft Foundry 모델, MCP 서버를 포함한 구조는 Azure Container Apps 또는 Azure Kubernetes Service(AKS)에 배포할 수 있습니다. 이러한 서비스는 프로덕션 워크로드에 필요한 확장성과 안정성을 제공합니다.

- **모니터링:**  
  배포 후에는 실제 사용 환경에서 에이전트 성능을 지속적으로 모니터링하세요. 로깅 및 알림 시스템을 설정하여 이상 동작을 감지하세요. Microsoft Foundry의 관찰성(Observability) 기능도 유용합니다.  
  https://learn.microsoft.com/azure/ai-foundry/how-to/monitor-applications  

- **지속적인 개선:**  
  AI 에이전트는 지속적으로 개선할 수 있습니다. 사용자 피드백과 상호작용 데이터를 분석하여 모델, 프롬프트, 도구를 정기적으로 업데이트하세요.

---

## 집에서 실습해 보기

이 실습은 언제든지 다시 진행할 수 있습니다.  
전체 실습 가이드는 다음 GitHub 리포지토리에서 확인할 수 있습니다:

https://github.com/microsoft/aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol

---