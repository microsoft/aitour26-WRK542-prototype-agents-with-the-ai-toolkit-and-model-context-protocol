# 에이전트 구축: Agent Builder로 Zava 매장 운영(Store Ops) 에이전트 만들기

이 섹션에서는 Foundry Toolkit의 Agent Builder를 사용해 Cora 에이전트를 만들고 도구를 추가하여, 사용자를 대신해 액션을 수행할 수 있도록 구성합니다. Agent Builder는 프롬프트 엔지니어링과 MCP 서버 등 도구 통합을 포함해 에이전트 구축을 위한 엔지니어링 워크플로를 간소화합니다.

## Step 1: Agent Builder 살펴보기

Agent Builder에 접근하려면 Foundry Toolkit 뷰에서 **Developer Tools** 아래의 **Build** 섹션을 찾습니다. 펼친 뒤 **Create Agent**를 클릭합니다. 다음으로 **Open Agent Builder**를 선택해 Visual Studio Code의 새 탭에서 Agent Builder 인터페이스를 엽니다.

![Create New Agent](../../img/create-new-agent.png)

Agent Builder UI는 크게 두 영역으로 구성됩니다. 왼쪽은 에이전트 이름, 모델 선택, 지시문(instructions), 관련 도구 등 에이전트의 기본 정보를 정의하는 영역입니다. 오른쪽은 에이전트와 채팅하고 응답을 평가하는 영역입니다.

![Agent Builder](../../img/agent-builder.png)

> [!NOTE]
> Evaluation 기능은 에이전트 Instructions 안에 변수(variable)를 정의한 뒤에만 사용할 수 있습니다. 평가 기능은 이 실습의 Bonus 섹션에서 더 자세히 다룹니다.

## Step 2: 에이전트 생성

이제 Zava의 Cora 에이전트를 만들어 보겠습니다. **Agent name** 필드에 **Cora**를 입력합니다. 에이전트의 **Model**은 **gpt-5.3-chat (via Microsoft Foundry)** 모델 인스턴스를 선택합니다.

## Step 3: 에이전트 Instructions 제공

앞서 Model Playground에서 했던 것처럼, 시스템 프롬프트를 통해 에이전트의 동작 방식을 정의해야 합니다.

> [!TIP]
> Agent Builder에는 에이전트 작업 설명으로부터 LLM이 Instructions를 생성하는 **Generate** 기능이 있습니다.
> 또한 시작점으로 사용할 수 있는 샘플 Instructions를 제공하는 **Inspire me** 기능도 있습니다.
> 지시문을 작성할 때 도움이 필요하면 두 기능을 활용해 보세요.

![Generate Agent Instruction](../../img/generate-agent-instruction.png)

이 실습에서는 [이전 섹션](./03_Model_Augmentation.md)에서 사용한 것과 유사한 Instructions를 사용합니다.

```
# **Zava Sales & Inventory Agent – System Instructions**

## **1. Role & Context**
You are **Cora**, an internal assistant for **Zava** (a DIY retailer). You help store managers and head office staff analyze sales and manage inventory.
* **Tone:** Professional, precise, and helpful.
* **Financial Year (FY):** Starts **July 1**.
  * Q1: Jul–Sep | Q2: Oct–Dec | Q3: Jan–Mar | Q4: Apr–Jun.
* **Date Handling:** Always convert relative dates (e.g., "last month", "Q1") to ISO format (YYYY-MM-DD) for database queries.

---

## **2. Tool Usage Strategy (The "Router")**
You must analyze the user's intent to select the correct tool workflow:

### **A. Product Discovery (Qualitative)**
* **Trigger:** User asks for features, descriptions, use-cases, or fuzzy names (e.g., "waterproof light", "drill for concrete").
* **Action:** **ALWAYS** use `semantic_search_products` first.
* **Restriction:** **NEVER** use SQL to search for product descriptions or names.

### **B. Sales & Data Analysis (Quantitative)**
* **Trigger:** User asks for revenue, sales volume, top stores, or aggregated metrics.
* **Action:** Use `execute_sales_query`.
* **Requirement:** If the query is time-sensitive (e.g., "sales last month"), **ALWAYS** call `get_current_utc_date` **FIRST** to calculate the correct date range.

### **C. Inventory & Actions (Read/Write)**
* **Trigger:** User asks about stock levels or moving items.
* **Workflow:**
  1. **Identify:** Use `semantic_search_products` to get the product id if unknown.
  2. **Check:** Use `get_stock_level_by_product_id` to see availability and get internal `store_id`s.
  3. **Confirm (CRITICAL):** If the user requests a transfer, you must **STOP** and ask for confirmation: *"Please confirm: Transfer [Quantity] of [Product Name] from [Store A] to [Store B]?"*
  4. **Execute:** Only after confirmation, call `transfer_stock`.

---

## **3. Content Boundaries & Safety**
* **Write Protection:** Never execute `transfer_stock` without explicit user confirmation in the current conversation turn.
* **ID Privacy:** You must handle Entity IDs (e.g., `store_id: 4`, `product_id: 99`) internally to execute tools, but **NEVER** display them in the final response to the user. Use Store Names and Product Names instead.
* **No Hallucinations:** If a tool returns no data, say "I couldn't find any data matching that request." Do not invent numbers or products.
* **Out of Scope:**
  > "I'm here to assist with Zava sales, inventory, and product data. For other topics, please contact IT support."

---

## **4. Response Guidelines**
* **Format:** Use Markdown tables for lists of products or sales data.
* **Zero Results:**
  * *Semantic Search:* If no products match, clearly state: "I couldn't find any products matching that description."
  * *Sales Data:* If SQL returns empty, state: "No sales records found for that specific criteria."
* **Language:** Translate the response to the user's language.
* **Clarification:** Don't make assumptions if unclear—ask for clarification.

---

## **5. Suggested Questions (Offer up to 10)**
* What were the top-selling categories last month (online vs physical)?
* What was the total revenue for Q2 2024?
* Which stores are low on circuit breakers right now?
* Check stock for the "Pro-Series Hammer Drill" across all stores
* What are the top 10 products by revenue across all US stores this month?
* Transfer 5 units of "Pro-Series Hammer Drill" from one store to another
* List online sales by category for last month
* Which stores have unusually high returns compared to last month?

---

## **6. Implementation Reminders**
* **Order of Operations:** Time Check → Search/Query → Formatting.
* **Limit:** Default to `LIMIT 20` for all SQL queries and searches to maintain readability.
* **Handling Ambiguity:** If `semantic_search_products` returns results with low similarity scores, preface the list with: *"Here are the most likely product candidates I found for your search."*

Respond in Korean.
```

위 Instructions에서 매장 운영(Store Ops) 작업(매출 분석, 재고 확인, 안전한 재고 이동)을 위한 명시적 가이드를 추가했다는 점에 주목하세요.
다만 이 시점에서는 Cora가 아직 매출/재고 데이터에 접근할 수 없습니다. 다음 단계에서 이를 연결합니다.

## Step 4: MCP 서버 시작

> [!NOTE]
> [Model Context Protocol (MCP)](https://modelcontextprotocol.io/docs/getting-started/intro)는 대규모 언어 모델(LLM)과 외부 도구/애플리케이션/데이터 소스 간 통신을 최적화하는 강력한 표준 프레임워크입니다.

앞선 **Model Augmentation**에서는 파일 첨부 형태로 그라운딩 데이터를 모델에 추가했습니다. 빠른 테스트에는 편리하지만, 매장 운영은 시간이 지나며 변하는 라이브 데이터(매출 및 재고)가 필요합니다.

이를 위해 Cora를 이 워크숍용으로 구성된 두 개의 MCP 서버에 연결합니다.

- **Sales Analysis MCP server** (판매 지표 + 제품 시맨틱 검색)
- **Inventory MCP server** (재고 수준 + 안전한 재고 이동)

서버를 시작하려면 Visual Studio Code에서 **<kbd>CTRL+F5</kbd>**를 눌러 MCP Servers를 시작하고, 두 서버가 초기화될 때까지 기다립니다. 서버마다 하나씩, 총 두 개의 새 터미널 창이 열립니다.
두 터미널 창 모두에 `Uvicorn is running on port XXXX` 메시지가 표시되어 서버가 실행 중임을 확인하세요.

![MCP Servers running](../../img/mcp_servers_running.png)

> [!TIP]
> UI를 통해서도 MCP 서버를 시작할 수 있습니다. 'Run'->'Run without debugging'을 클릭하세요.
> ![Run and debug](../../img/run-and-debug.png)

> [!WARNING]
> 최초 시도에서 importlib 오류로 서버 시작에 실패하면, 다시 실행해 보세요. 이는 Python 바이트코드 컴파일과 Windows 파일 시스템 동작 사이의 타이밍 이슈로 알려져 있습니다. 서버를 다시 실행하면(두 번째 시도) 필요한 파일이 캐시되어 정상적으로 시작됩니다.

## Step 5: Sales MCP 서버 도구를 에이전트에 추가

이 실습에서는 두 서버 모두에서 작고 집중된 도구 세트를 에이전트에 부여합니다(제품 검색, 재고 확인, 매출 쿼리 실행, 확인을 동반한 재고 이동을 수행하기에 충분한 최소 구성).

Agent Builder로 돌아가서 **Tools** 옆의 **+** 아이콘을 선택해 도구 추가 마법사를 엽니다.

![Add tool.](../../img/add-tool.png)

**Configured** 탭에서 아래로 스크롤해 **Local Tools** 섹션을 찾고 **zava-sales-analysis-server**를 선택합니다.

![Select Sales Analysis Server](../../img/select-sales-analysis-server.png)

이제 에이전트의 **Tool** 섹션에 서버가 표시됩니다.

> [!NOTE]
> Sales Analysis MCP 서버의 도구를 추가하기 전에, 해당 서버가 실행 중인지 확인하세요.

## Step 6: 에이전트로 매출 쿼리 테스트

이제 Cora 에이전트가 매장 운영을 위한 도구 호출을 수행하는지 테스트할 준비가 됐습니다. **Agent Builder** 탭의 오른쪽 채팅 패널에서 아래 경로에 있는 차단기 이미지를 첨부합니다.

```
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png
```

그 다음 아래 텍스트 프롬프트를 전송합니다.

```
I’m the store manager. Identify what’s in the photo, then find the closest matching circuit breaker product in our catalog and show current stock across all stores.
```

![Agent Builder Playground](../../img/agent-builder-playground.png)

에이전트가 도구 호출을 실행하면, 어떤 도구가 호출되었는지 나타내는 섹션이 출력에 표시됩니다.

![Tool call in the agent's output.](../../img/tool-call.png)

언어 모델은 비결정적(non-deterministic)이므로, 프롬프트를 실행할 때마다 출력이 달라질 수 있습니다. 아래는 에이전트 응답 예시입니다.

> This appears to be a circuit breaker.
>
> To match it correctly, I’d verify the amperage rating, pole type (single vs double), and brand/series from the label.
>
> I found the closest matching circuit breaker product in our catalog and checked stock across stores. Here’s current availability by store, plus the best next action if we need to rebalance inventory.

도구가 기대대로 사용되지 않았다면, **Instructions**를 업데이트해 어떤 작업에 어떤 도구를 사용해야 하는지 더 명시적으로 작성하는 것이 도움이 됩니다.

다음 질문도 시도해 보세요.

```
What were the sales by store for the last quarter
```

```
What are our top 3 selling products last year
```

### Step 7: Inventory MCP 서버 도구를 에이전트에 추가

이제 재고 도구를 추가해 재고 수준을 확인하고 안전한 재고 이동을 수행할 수 있도록 구성합니다.
방법은 매출 도구 구성과 동일한 절차를 반복하면 됩니다.

1. Agent Builder에서 **Tools** 옆의 **+** 아이콘을 클릭합니다.
2. **Configured** 탭의 **Local Tools** 섹션에서 **zava-inventory-server**를 선택합니다.
3. 이제 **Tool** 섹션에 매출 서버와 함께 재고 서버가 표시되어야 합니다.

> [!NOTE]
> Inventory MCP 서버의 도구를 추가하기 전에, 해당 서버가 실행 중인지 확인하세요.

## Step 8: 재고 확인 및 재고 이동 테스트

재고 이동을 테스트하려면 아래와 같은 요청을 전송해 보세요.

```
Transfer 5 units of the Single Pole Circuit Breaker 20A from a store with surplus stock to the online store.
```

에이전트가 재고 이동에 대한 확인을 요청할 것입니다. 재고 이동을 실행하려면 `yes`를 입력하세요.

## 에이전트를 로컬에 저장

테스트를 마치면 Agent Builder 오른쪽 상단의 **Save to Local** 버튼을 클릭해 에이전트 구성을 로컬에 저장하세요. 로컬 저장을 해두면 다음에 같은 구성을 다시 사용하기 위해 처음부터 재구성할 필요가 없습니다.

Instructions와 도구를 조정하면서 여러 버전을 저장해 비교하는 것도 가능합니다.
