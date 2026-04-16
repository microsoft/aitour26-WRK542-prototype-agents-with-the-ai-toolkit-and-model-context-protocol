# 코드로 마이그레이션(Migrate to Code)

이 섹션에서는 Foundry Toolkit에서 만든 에이전트를 코드 기반 워크플로로 마이그레이션하는 방법을 학습합니다.

Foundry Toolkit은 Agent Builder에서 생성한 에이전트를 위한 코드도 생성해 줍니다. 선호하는 SDK와 프로그래밍 언어를 선택할 수 있으며, 생성된 코드 파일을 가져와 여러분의 앱에 통합할 수 있습니다.

## Step 1: 코드 생성

Agent Builder에서 인터페이스 오른쪽 상단의 **View Code** 버튼을 클릭합니다.

![View code button.](../../img/view-code.png)

> [!NOTE]
> 이전 섹션에서 설명한 대로 에이전트를 로컬에 저장하지 않았다면 **View Code** 옵션이 표시되지 않습니다. 먼저 로컬 저장을 완료했는지 확인하세요.

프롬프트가 뜨면 선호하는 클라이언트 SDK(예: *Microsoft Agent Framework*)와 프로그래밍 언어(예: *Python*)를 선택합니다. 새 파일이 생성되면 워크스페이스에 파일을 저장합니다(예: 'src/cora-app.py').

## Step 2: 코드 확인

스크립트를 실행하기 전에 파일 내용을 검토하세요. 실행 전 수정이 필요한 placeholder가 포함되어 있을 수 있습니다. 스크립트 로직이 이해되지 않으면 GitHub Copilot Chat의 **Ask** 모드를 활용할 수 있습니다.

GitHub Copilot Chat을 열려면 Visual Studio Code 상단의 **Toggle Chat** 아이콘을 선택합니다.

![Toggle chat button.](../../img/toggle-chat.png)

생성된 코드 파일을 워크스페이스에 'src/cora-app.py'로 저장합니다. GitHub Copilot Chat이 파일을 컨텍스트로 사용할 수 있도록 해당 파일을 활성화해 둡니다. 또는 프롬프트에서 특정 파일을 직접 언급해도 됩니다.

![GitHub Copilot Chat in Ask mode.](../../img/ghcp-ask-mode.png)

> [!NOTE]
> 파일 이름 옆에 '+' 아이콘이 보이면, cora-app.py가 Copilot Chat에 의해 컨텍스트로 제안되었지만 아직 추가되지 않은 상태입니다. '+' 아이콘을 클릭해 컨텍스트로 추가하세요.
>
> ![Suggested file as context](../../img/suggested_file_context.png)

예를 들어 아래 프롬프트를 시도해 보세요.

```
Explain what's happening in this script.
```

변경이 필요하다면 **Agent** 모드로 전환해 변경을 요청할 수 있습니다. 파일 변경은 스크립트에 반영(커밋)되기 전에 승인을 요청받게 됩니다.

## (선택) Bonus

코드를 실행해 보고 싶다면 파일을 저장한 뒤, 코드 파일 상단의 주석에 있는 안내를 따르세요. 선택한 클라이언트 SDK 및 언어에 따라 지침이 달라질 수 있습니다.

예를 들어 **Microsoft Agent Framework** SDK와 **Python**을 선택했다면, 아래 안내를 따릅니다.

1. cora-app.py 파일에서 MCP 서버 구성이 있는 섹션을 찾고, URL 및 포트가 로컬에서 실행 중인 MCP 서버와 일치하는지 확인합니다.

2. MCP Server URL은 두 개이며, 끝에 붙은 `/`를 제거해야 합니다. 형식은 `http://localhost:PORT_NUMBER/mcp`여야 합니다.

    ![MCP Server URL fix](../../img/mcp_url_fix.png)

3. 상단 메뉴에서 **Terminal** -> **New Terminal**을 선택해 Visual Studio Code에서 새 터미널을 엽니다.

4. 필요한 종속성을 설치합니다.

```
pip install --no-deps agent-framework==1.0.0rc3 agent-framework-core==1.0.0rc3 agent-framework-azure-ai==1.0.0rc3
```

4. Azure에 인증합니다.

```
az login
```

브라우저 창을 열고 코드를 입력해 인증을 완료하라는 안내가 표시됩니다. 터미널로 돌아오면 **Enter**를 눌러 Azure 구독 선택을 확정합니다.

5. 코드 파일이 저장된 디렉터리로 이동합니다.

```
cd src
```

6. 스크립트를 실행합니다.

```
python cora-app.py
```

> [!TIP]
> 스크립트 내에서 에이전트에 제공되는 사용자 입력을 커스터마이징해 다양한 시나리오를 테스트해 볼 수 있습니다. 스크립트에서 'USER_INPUTS' 배열 정의를 찾고 입력 값을 변경해 보세요. 예:

```
USER_INPUTS = [
    "What are the top 5 best-selling products in the last month?",
    "Which stores have low stock on circuit breakers right now?"
]
```

> [!NOTE]
> 스크립트를 실행하기 전에 MCP 서버가 실행 중인지 확인하세요. 이전 섹션을 그대로 따라왔다면 MCP 서버는 이미 로컬에서 실행 중이어야 합니다.

GitHub Copilot Chat의 Agent 모드를 활용해 Cora 에이전트의 UI 파일을 만드는 작업을 도와달라고 요청해 볼 수도 있습니다. 또한 Agent 모드에서 에이전트 스크립트를 앱 UI에 통합해, 작동하는 에이전트 프로토타입을 만드는 것도 가능합니다.

## Key Takeaways

- Agent Builder는 여러 프로그래밍 언어와 SDK에 대해 에이전트 코드를 자동 생성해, 프로토타입에서 프로덕션으로 전환하는 과정을 쉽게 해줍니다.
- 생성된 코드에는 실행 전에 수정해야 하는 placeholder가 있을 수 있으므로, 개발자는 로직을 이해하고 자신의 요구에 맞게 조정해야 합니다.
- GitHub Copilot Chat의 Ask/Agent 모드를 사용하면 생성된 코드를 이해하고, UI 같은 추가 구성 요소를 만들어 완전한 에이전트 앱을 구성하는 데 도움이 됩니다.

Click **Next** to proceed to the following section of the lab.
