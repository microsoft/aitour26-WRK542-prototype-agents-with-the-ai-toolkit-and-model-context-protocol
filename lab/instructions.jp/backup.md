@lab.Title
# はじめに  
>[!NOTE]
> このワークショップは **75分** で構成されており、Visual Studio Code 上で Foundry Toolkit と Microsoft Foundry を活用し、ビジネスシナリオに合わせたマルチモーダルエージェントをプロトタイピングする実践的な体験を提供します。

## 学習目標  
このワークショップを完了すると、以下のことができるようになります。

• Foundry Toolkit モデルカタログでさまざまなモデルを探索・比較し、ユースケースに最適なモデルを選択できます。  

• Foundry Toolkit Playground でプロンプトエンジニアリングとコンテキストデータを活用してモデルを強化し、より正確で根拠のある回答を生成できます。  

• Foundry Toolkit Agent Builder を使用して、MCP（Model Context Protocol）ベースのツールと指示を組み合わせてエージェントをプロトタイピングできます。  

## リソース  
> [!TIP]
> ログイン情報とサブスクリプション情報は **Resources** タブで確認できます。

## ラボの概要  

このラボでは、Microsoft Foundry と Foundry Toolkit を使用したマルチモーダルエージェントのプロトタイピングプロセス全体を、4 つのセクションに分けて解説します。

1. **パート 1 - モデル選択**  
   AI ソリューションを構築する際、モデルの選択は重要なステップです。このセクションでは、Foundry Toolkit のモデルカタログを探索し、ビジネスシナリオに最適なモデルを比較・選択します。

2. **パート 2 - モデルの強化**  
   選択したモデルをプロンプトエンジニアリングとコンテキストデータで強化し、特定のユースケースにより適した性能と関連性を確保する方法を学びます。

3. **パート 3 - エージェントのプロトタイピング**  
  Foundry Toolkit Agent Builder を使用してエージェントをプロトタイピングします。選択・強化したモデルを MCP（Model Context Protocol）ベースのツールおよび指示と組み合わせます。

4. **パート 4 - プロトタイプからコードへ**  
   最後に、プロトタイプを実際のアプリケーションに組み込めるコードとしてエクスポートする方法を学習します。

## ビジネスシナリオ  

このワークショップでは、**Zava** という、アメリカ国内で **20 店舗とオンラインチャネルを運営する DIY（セルフリノベーション）小売業者** のための AI エージェントを構築します。  
シナリオは **店舗運営** と **本社の販売分析** に焦点を当て、在庫確認および店舗間の在庫移動機能も含みます。

### 課題

Zava の店舗マネージャーと本社チームは、以下のような質問に迅速に答えられる必要があります。

• 「先月最も売れたカテゴリは何ですか？」  
• 「主要商品の在庫が不足している店舗はどこですか？」  
• 「需要を満たすために、ある店舗の在庫を別の店舗に移動できますか？」  

また、写真（例：ブレーカーの写真）をもとに製品を識別し、在庫を確認し、必要な対応を行うといったマルチモーダルタスクも処理する必要があります。

### 解決策：Zava 店舗運営・販売分析エージェント **Cora**

皆さんは、以下の機能を持つ社内用 AI アシスタント **Cora** を開発します。

1. **マルチモーダル入力の理解**：スタッフが提供するテキストと画像（例：製品写真、SKU ラベル）を処理  
2. **製品カタログ検索**：自然言語クエリまたは画像ベースの説明を使って関連製品を検索  
3. **業務意思決定のサポート**：販売実績に関する質問に答え、実行可能なサマリーを提供  
4. **在庫確認**：オンライン・オフライン店舗のリアルタイム在庫データを照会  
5. **安全な在庫移動の処理**：店舗間の在庫移動リクエストを作成し、明示的な確認手順を実施  

### なぜ重要なのか  

このエージェントは、Zava が以下を実現するのに役立ちます。

• **より迅速な販売インサイトの提供** による意思決定の向上  
• **在庫不足の削減** - 低在庫を早期に検出し、店舗間で移動可能  
• **レポートの標準化** - 店舗マネージャーと本社チーム間で一貫したレポーティング  
• **マルチチャネル運営のサポート** - 店舗とオンライン間の在庫調整  

このワークショップを通じて、Foundry Toolkit と Microsoft Foundry を使って Cora の機能を構築・テスト・改善し、実際のビジネスシナリオに適用可能な AI エージェントの作り方を習得します。


===
# 01-はじめに

> [!TIP] 
> **Foundry Toolkit とは？**  
> Foundry Toolkit は Visual Studio Code 用の拡張機能で、さまざまな AI モデルとサービスを一つの統合インターフェースで探索・操作できるツールです。  
> これにより、開発者は GitHub、Microsoft Foundry、ローカル環境など複数のプラットフォームにホストされたオープンソースおよび商用モデルを簡単に比較・活用できます。  
> Foundry Toolkit は、モデル選択・プロンプトエンジニアリング・エージェントのプロトタイピングとテストをコードエディタ内で直接実行できるようにし、生成 AI 開発ワークフローを大幅に向上させます。

## Windows にログインする

最初のステップとして、**Resources** タブに記載されている Skillable VM の認証情報を使用して、ラボの仮想マシン（VM）にログインします。

![VM login credentials](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/vm_login_credentials.png)

> [!TIP]
> **Skillable を初めて使用する方へ**  
> 「T」アイコン（例：+++Admin+++）は、VM 内の現在のカーソル位置に値を自動入力する機能です。  
> ワンクリックで入力ミスを減らし、作業を効率化できます。  
> また、すべての画像は必要に応じてクリックして拡大できます。

## GitHub にログインする

このワークショップでは、GitHub Enterprise（GHE）アカウントを使用して、Foundry Toolkit Model Catalog の GitHub ホステッドモデルと Visual Studio Code の GitHub Copilot 機能を活用します。

以下の手順に従って GitHub Enterprise（GHE）アカウントにログインし、このラボ用の Codespace を作成します。

1. タスクバーから Edge ブラウザを開きます。  
   すでに **[GHE ログインページ](https://github.com/enterprises/skillable-events)** が開かれています。

2. 以下の認証情報でログインします。

- Username: +++@lab.CloudPortalCredential(User1).Username+++  
- TAP: +++@lab.CloudPortalCredential(User1).TAP+++  

ログイン成功の通知を受け取ったら、ブラウザタブを最小化し、Visual Studio Code でワークショップ環境を開きます。

## Visual Studio Code でワークショップ環境を開く

VM にログインした後、画面下部のタスクバーにあるターミナルアイコンをクリックしてターミナルを開きます。

![Open terminal](https://raw.githubusercontent.com/microsoft/aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/open_terminal.png)

以下のコマンドブロックをターミナルにコピー＆ペーストして **Enter** を押します。  
このコマンドは、ワークショップリポジトリを更新し、Python 仮想環境を有効化し、VS Code でプロジェクトを開きます。

```powershell
; cd $HOME\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\ ` 
; git pull ` 
; Remove-Item -Recurse -Force .git ` 
; .\.venv\Scripts\activate `
; $env:OTEL_SDK_DISABLED="true" ` 
; code . 
```
> [!NOTE]
> 複数行をターミナルに貼り付けることへの警告が表示されます。**Paste anyway** をクリックして続行してください。

## Azure の認証

Visual Studio Code 環境には、すでに 2 つの拡張機能がインストールされているはずです。

- **Foundry Toolkit**：このラボでさまざまな AI モデルおよびサービスと連携するために使用します。
- **Microsoft Foundry 拡張機能**：Foundry Toolkit パッケージの一部としてインストールされ、Microsoft Foundry にホストされたモデルにアクセスできます。  
  両拡張機能が正しくインストールされていれば、以下のスクリーンショットのように VS Code 左側サイドバーにアイコンが表示されます。

![Installed extensions](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/installed_extensions.png)

> [!TIP]
> アイコンが表示されない場合は、サイドバー下部の **…**（その他）をクリックして拡張機能の一覧を確認してください。

次に、Microsoft Foundry 拡張機能のアイコンをクリックし、  
**Set Default Project** → **Sign in to Azure** を選択します。

![Set Default Project](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/set_default_project.png)

Azure ログインのポップアップが表示されたら、**Allow** をクリックします。

![Azure Login Popup](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/azure_login_popup.png)

続いて表示される画面で、以下の認証情報を入力します。

- Email: +++@lab.CloudPortalCredential(User1).Username+++  
- TAP: +++@lab.CloudPortalCredential(User1).TAP+++  

> [!NOTE]
> 「このデバイスのすべてのアプリとサイトに自動ログインを許可する」というメッセージが表示された場合は、**Yes, all apps** を選択してください。  
> その後、**Done** をクリックしてログイン手順を完了し、VS Code に戻ります。

VS Code に戻ると、使用する Foundry プロジェクトを選択するよう求められます。  
このワークショップのために事前にデプロイされた単一プロジェクトを選択します。

![Select Project](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_project.png)

## GitHub Copilot AI 機能の有効化

このワークショップでは GitHub Copilot の AI 機能も使用します。  
そのため、先ほど Edge ブラウザでログインした同じ GitHub Enterprise（GHE）アカウントで VS Code にもログインする必要があります。

1. VS Code 右下の **Copilot アイコン**（現在「Signed out」と表示されている）をクリックします。
2. **Sign in to use AI features** → **Continue with GitHub** を選択します。

![GitHub Copilot Sign In](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/github_copilot_sign_in.png)

3. 新しいブラウザタブが開いたら、**Continue** をクリックして同じ GHE アカウントでログインします。  
   次の画面で **Authorize Visual Studio Code** をクリックします。

![Authorize GitHub Copilot](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/authorize_github_copilot.png)

4. ブラウザが Visual Studio Code を開こうとしているというメッセージが表示されたら、  
   **Open Visual Studio Code** をクリックして VS Code に戻ります。

## 準備完了

VS Code で Foundry Toolkit と Microsoft Foundry モデルを使用する準備が整いました。  
次のステップでは、モデルカタログを探索し、モデルと対話してみましょう。

**Next** をクリックして次のセクションに進んでください。


===
# 02-モデル選択

モデル選択：Foundry Toolkit Model Catalog の探索

このセクションでは、Foundry Toolkit Model Catalog を探索して、マルチモーダルエージェントプロジェクトに使用するモデルを発見・絞り込み・比較する方法を学びます。  
モデルカタログは、GitHub、Microsoft Foundry、OpenAI などさまざまなプロバイダーのモデルにアクセスできます。

## ステップ 1：フィルターを適用して選択肢を絞り込む

1. 左サイドバーで **Foundry Toolkit** アイコンを探します。  
2. アイコンをクリックして拡張パネルを開きます。  
3. **Model Catalog** をクリックして、利用可能なモデルの一覧に移動します。

![Model Catalog](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_catalog.png)

ページ上部には人気モデルが表示され、スクロールすると全モデルの一覧を確認できます。

モデルが多数あるため、フィルターオプションを使って必要に合わせて絞り込むことができます。

![Filter Options](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/filter_options.png)

### ホスティングプロバイダー（Hosted by）でフィルタリング

1. **Hosted by** フィルターのドロップダウンをクリックします。  
   GitHub、Microsoft Foundry、OpenAI、Ollama、ONNX などのオプションがあります。

2. **GitHub** を選択して、プロトタイピングに適した無料モデルを確認します。

> [!NOTE]
> GitHub モデルは無料で利用でき、試し始めるのに最適ですが、トークン使用量に制限があります。  
> コストを気にせず実験できますが、本番環境へのデプロイ時には GitHub または Microsoft Foundry の従量課金（pay‑as‑you‑go）オプションを検討してください。

### パブリッシャー（Publisher）でフィルタリング

1. **Publisher** フィルターのドロップダウンをクリックして、Microsoft、Meta、Cohere などのモデルプロバイダーで絞り込みます。  
2. **OpenAI** と **Mistral AI** を選択して、2 つの主要プロバイダーのモデルを確認します。

### モデル機能（Feature）でフィルタリング

1. **Feature** フィルターのドロップダウンをクリックして、画像・音声・動画処理、ツール呼び出しなどの機能で絞り込みます。  
2. **Image Attachment** を選択して、テキスト＋画像入力に対応したマルチモーダルモデルを探します。

## ステップ 2：モデルをコレクションに追加する

フィルターを適用すると、モデルの一覧が絞り込まれます。

この演習では、以下の 2 つのモデルを探します。

- **OpenAI GPT‑4o** - 強力なマルチモーダルモデル  
- **Mistral Small 3.1** - 高速でコスト効率に優れた軽量モデル  

> [!TIP]
> 2 つのモデルが見つからない場合は、**View All** をクリックしてフィルタリングされた全リストを確認してください。  
> または、左上の検索欄にモデル名を直接入力することもできます。
>
> ![View All](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/view_all.png)

各モデルカードで **Add Model** をクリックしてコレクションに追加します。

![Add Model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/add_model.png)

> [!NOTE]
> モデルが追加されると、ボタンが青から緑色の **Added** に変わります。

## ステップ 3：Playground を開く

1. モデルカードの **Try in Playground** をクリックします。  
   Playground では、モデルを直接テストして比較できます。

![Try in playground](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/try_in_playground.png)

2. GitHub の無料モデルにアクセスするために GitHub へのログインが必要です。  
   **Allow** をクリックして、前のセクションで使用した同じ GitHub アカウントで認証します。

> [!TIP]
> ログイン後、Foundry Toolkit 拡張パネルの `GitHub` → `My Resources` から追加したモデルを確認できます。
>
> ![Model collection](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_collection.png)
>
> 表示されない場合は、更新アイコンをクリックしてください。

3. **Model** フィールドに選択したモデルが表示されます。  
   例：**Mistral Small 3.1 (via GitHub)**

![Model Playground](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_playground.png)

> [!WARNING]
> Playground の初回起動時は、モデルの初期化によって読み込みに時間がかかる場合があります。

4. **Compare** ボタンをクリックして比較モードを有効にします。  
5. 2 番目のモデルとして **OpenAI GPT‑4o** を選択します。  
6. これで 2 つのモデルを並べて比較する準備ができました。

![Model Comparison](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/model_comparison.png)

## ステップ 4：テキストおよびマルチモーダル機能のテスト

> [!TIP]
> 比較モードは、同じ入力に対してモデルがどのように異なる応答をするかを明確に示してくれるため、モデル選択に非常に役立ちます。

まず、シンプルなテキストプロンプトを入力します。

1. テキスト入力欄（「Type a prompt」と表示されている場所）に以下のプロンプトを入力します。

```
I'm a store manager at a DIY retailer. What are the most important metrics to review in a weekly sales summary, and why? 
```

2. 紙飛行機アイコンをクリックして、両方のモデルで同時にプロンプトを実行します。

![Test the model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/test_the_model.png)

> [!WARNING]
> GitHub にホストされている無料ティアのモデル環境をテストしているため、特に複雑なプロンプトの場合、モデルの応答に遅延が生じる場合があります。

次に、以下のプロンプトを使ってモデルの推論能力をテストしてみましょう。

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

続いて、モデルの画像処理機能をテストしてみましょう。

1. テキスト入力欄に以下のプロンプトを入力します。
```
Describe what's in this image and what kind of electrical component it appears to be. 
```

2. 画像添付アイコンをクリックして、入力として使用する画像を追加します。

![Image Attachment](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/image_attachment.png)

3. ファイルエクスプローラーが開いたら、アップロードする画像ファイルを選択するよう求められます。以下のパスに移動します。

```
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png 
```

次に **circuit_breaker.png** ファイルを選択し、**Open** をクリックします。  
![Image File Path](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/image_file_path.png)

4. マルチモーダルプロンプトを両方のモデルに同時に送信します。

## ステップ 5：結果の分析と比較

以下の複数の観点から、2 つのモデルの結果を確認してください。

- **応答品質**：説明の深さと正確さ、および入力プロンプトとの一貫性を比較します。

- **詳細度**：どちらのモデルがより包括的で深い分析を提供していますか？

- **処理速度**：応答速度に違いがあるか確認します。

- **出力形式**：応答の明確さ、構成、および冗長さ（または簡潔さ）を評価します。

- **トークン使用量**：各モデルのトークン使用量を分析して、コスト面の影響を理解します。トークン使用量は、応答の長さだけでなく、各モデルのトークナイザー効率によっても異なる場合があります。

> [!TIP]
> 出力トークン数は、応答下部の文字数とともに表示されます。LLM は非決定的（non-deterministic）であるため、同じプロンプトを複数回実行してもトークン使用量に若干の差異が生じる場合があります。  
> ![Token usage](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/token_usage.png)

### GitHub Copilot を活用した比較分析

比較分析をより簡単に行うために、GitHub Copilot を使用して比較サマリーを生成できます。

GitHub Copilot Chat にアクセスするには、Visual Studio Code ウィンドウ上部の **Toggle Chat** アイコンをクリックします。

![Toggle chat button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/toggle-chat.png)

> [!NOTE]
> Copilot を初めて使用する際にログインを求められた場合は、**Sign-in → Continue with GitHub** を選択します。  
> その後、GitHub ログインページに移動したら、GitHub にホストされたモデルにアクセスする際に使用したアカウントでログインし、**Continue** をクリックします。

モデルとして **Claude Sonnet 4.5** が選択されていることを確認してください。選択されていない場合は、ドロップダウンメニューを開いて該当モデルを選択します。

![Select claude Sonnet 4.5](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_claude_sonnet.png)

Copilot チャットウィンドウで以下のプロンプトを入力してみてください。

```
I am exploring models for an AI agent that should support Zava - a DIY retailer with 20 stores across the United States and an online channel - on store operations and head office sales analysis. I am evaluating Mistral Small 3.1 and OpenAI GPT-4o. Which one would you recommend for this scenario, and why? Explain the trade-offs between models (e.g., reasoning ability, cost, latency, context length) so that I can make an informed choice. 
```

これに対して Copilot は、Foundry Toolkit の **Get AI Model Guidance** ツールを呼び出し、ユースケースに基づいたモデルの推薦を提供します。  
応答には、ツール呼び出しの詳細を含む展開可能なセクションとともに、比較分析の結果が表示されます。

![Get AI model guidance](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/get_ai_model_guidance.png)

> [!NOTE]
> GitHub Copilot が応答生成時に Foundry Toolkit ツールを自動的に呼び出さない場合は、チャットウィンドウに `#aitk` を入力して使用するツールを明示的に選択してから、プロンプトを送信できます。

## ステップ 6：Microsoft Foundry から選択したモデルを取得する

モデルの比較が終わったら、次の演習ステップで追加のプロトタイピングに使用するモデルを 1 つ選択します。  
この演習では **GPT-4o** を使用します。

> [!NOTE]
> 基本の Playground（シングルパネル・シングルモデル表示）に戻るには、モデル名の右側にある **Select this model** をクリックします。
>
> ![Select this model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_this_model.png)

次のステップでは DIY 小売業者 Zava に関する追加コンテキストデータをモデルに提供する予定のため、エンタープライズレベルのセキュリティおよびコンプライアンス機能を提供する Microsoft Foundry ホスティングモデルに切り替える必要があります。

**Model Playground** に戻り、**Model** ドロップダウンメニューを展開して、前の演習セクション（./01_Get_Started.md）でログインしたプロジェクトに事前デプロイされた Microsoft Foundry ホスティングの gpt-4o インスタンスを選択します。

![Select Azure Model](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/select_azure_model.png)

> [!NOTE]
> GitHub ホスティングモデルはプロトタイピングに非常に適していますが、Microsoft Foundry にホストされているモデルは本番デプロイに必要なエンタープライズ機能を提供します。これには、エンタープライズレベルのセキュリティおよびコンプライアンス、SLA（サービスレベルアグリーメント）、向上したパフォーマンスとスケーラビリティ、および他の Azure サービスとの統合が含まれます。

## まとめ

- Model Catalog は、複数のプロバイダーの AI モデルを一覧できる包括的なビューを提供します。

- フィルタリング機能により、要件に合ったモデルを素早く特定できます。

- Playground でのモデル比較により、データに基づいた意思決定が可能になります。

- 異なるホスティングオプションは、開発ステージに応じてそれぞれ異なるメリットを提供します。

- 組み込みの比較ツールを活用することで、マルチモーダル機能も効果的にテストできます。

このような探索プロセスを通じて、パフォーマンス・コスト・機能・実装要件などをバランスよく考慮し、特定のユースケースに最適なモデルを選択できます。

次の演習ステップに進むには **Next** をクリックしてください。

===

# モデルの強化：パフォーマンス向上のためのコンテキスト強化

このセクションでは、選択したモデルのパフォーマンスと特定ユースケースへの適合性を高めるために、プロンプトエンジニアリングとコンテキストデータを活用する方法を学びます。これは、AI モデルをビジネスシナリオ固有の要件に合わせて調整するうえで非常に重要なステップです。

## ステップ 1：システムメッセージの設計

システムメッセージは、AI モデルの動作とコンテキストを定義するプロンプトの重要な構成要素です。これにより、モデルは自身の役割と実行すべきタスクの具体的な要件を理解します。効果的なシステムメッセージを作成するための主な考慮事項は次のとおりです。

1. 明確かつ簡潔に記述する：インタラクションの目的と期待される結果を明確に説明します。曖昧さを避けて、モデルがタスクを正確に理解できるようにします。  
2. 十分なコンテキストを提供する：モデルがより正確でコンテキストに即した回答を生成できるよう、関連する背景情報を含めます。  
3. 期待事項を明示する：応答の形式・長さ・スタイルなど、必要な制約条件や要件を具体的に指定します。  
4. 複雑な指示は分割して記述する：タスクが複雑な場合は、ステップごとに分けてシンプルな指示として提供し、モデルが効果的に従えるようにします。  

Playground の右側パネルの **System Prompt** 入力欄に以下のシステムメッセージを入力してください。

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

このシステムメッセージには以下が含まれています。

- アシスタントの役割と責任の明確な定義（店舗運営＋本社営業分析）  
- 応答方法に関する具体的なガイドライン（簡潔で実行可能、かつ最初に明確化のための質問をする）  
- 業務アクションに対するセーフガード（在庫移動前に必ず明示的な確認を求める）  

## ステップ 2：マルチモーダル入力によるシステムメッセージのテスト

システムプロンプトを設定したので、マルチモーダルユーザープロンプトでシステムをテストしてみましょう。Playground のチャットで画像添付アイコンをクリックして、会話コンテキストに画像をアップロードします。次に、以下のパスにあるブレーカーの画像を選択します。

```
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png 
```

以下のユーザープロンプトと一緒に使用してください。

```
Here is a photo from the store. What is this component and what details should I capture (e.g., amperage, pole type) before searching our catalog and checking stock? 
```

モデルは画像を分析し、そのコンポーネントの説明とともに、カタログ検索および在庫確認前に収集すべき詳細情報を提案します。応答がシステムメッセージで定義した期待事項と一致しているか確認してください。

次に、Zava ビジネスに関係のないユーザーの質問でモデルをテストしてみましょう。以下のプロンプトを入力してください。

```
What's the weather like in San Francisco today?  
```

モデルは、Zava 関連の業務リクエストのみ対応できる旨を丁重に案内するはずです。これはシステムメッセージの指示に正しく従っていることを示しています。

## ステップ 3：グラウンディングデータの追加

システムメッセージに加えて、コンテキストデータを提供することでモデルがより関連性の高い正確な回答を生成するのに大いに役立ちます。このデータにはビジネス・製品・サービス・その他の関連情報が含まれ、モデルがシナリオをよりよく理解するのを助けます。

今回のユースケースでは、Zava の製品カタログに関する一部の情報をモデルに提供して、内部の質問に答える際に製品詳細を任意に生成しないようにします。

グラウンディングデータを追加するために、Playground の**ファイル添付機能**を使用します。これにより、モデルが応答生成時に参照できるドキュメントをアップロードできます。

アップロードするドキュメントは、Zava 製品カタログの一部を含む JSON ファイルです。内容を確認するには、`/data/` フォルダに移動して `zava_product_catalog.json` ファイルを探し、コードエディタで開いてください。

1. プロンプト入力エリアのファイル添付アイコンをクリックします。  
![File attachment icon](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/file_attachment_icon.png)

2. `/data/` ディレクトリから `zava_product_catalog.json` ファイルを選択します。

> [!TIP]
> 開いたウィンドウで以下のパスからデータディレクトリを見つけることができます。
> ```
> C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\data
> ```

![Uploading Grounding Data File](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/uploading_grounding_data_file.png)

3. ファイルがアップロードされると、プロンプト入力エリアの下に添付ファイルとして表示されます。

4. テキスト入力欄に以下のプロンプトを入力します。

```
From the attached Zava product catalog, suggest a circuit breaker option that would commonly be used for a 15-amp home circuit, and explain what you would check before recommending it.
```

モデルはアップロードされた製品カタログを分析し、リクエストに適したブレーカーオプションを根拠とともに提案します。

内部的には、添付データが自動的にプロンプトコンテキストに含まれ、モデルがより情報に基づいた関連性の高い応答を生成できるようになります。

もちろん、このアプローチには限界があります。モデルはプロンプトコンテキストで処理できるテキスト量に制限があり、含めるコンテキストが多いほど応答レイテンシとコストが増加します。大きなデータセットや複雑なシナリオの場合、現在のユーザークエリに最も関連性の高い情報だけをプロンプトに含めるよう、より高度な検索（リトリーバル）メカニズムを実装する必要があります。これについては次のセクションで詳しく説明します。

### まとめ

- 効果的なシステムメッセージの設計は、モデルの動作を誘導し、関連性の高い応答を確保するために不可欠です。  

- ファイル添付によるコンテキストデータの提供は、モデルのパフォーマンスと関連性を大幅に向上させることができます。  

- マルチモーダル入力のテストは、システムメッセージとコンテキストデータの効果を検証するのに役立ちます。  

- グラウンディングデータは、モデルの入力制限に合わせて関連性があり簡潔に保つ必要があります。  

次の演習セクションに進むには **Next** をクリックしてください。
 
===

# エージェントの構築：Agent Builder を使用して Zava 店舗運営エージェント Cora を作成する

このセクションでは、Foundry Toolkit の Agent Builder を使用して Cora エージェントを作成し、ユーザーに代わってタスクを実行できるようにツールを接続する方法を学びます。  
Agent Builder は、プロンプトエンジニアリングや MCP サーバーなどのツール統合を含む、エージェント構築のためのエンジニアリングワークフローを効率化します。

## ステップ 1：Agent Builder を確認する

Foundry Toolkit 画面で **Agent Builder** を選択してアクセスします。

![Agent Builder](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/agent-builder.png)

Agent Builder のインターフェースは 2 つのエリアで構成されています。  
左側のエリアでは、エージェントの基本情報（名前、モデルの選択、指示、接続するツールなど）を設定できます。  
右側のエリアでは、エージェントと直接対話して応答をテスト・評価できます。

> [!NOTE]
> 評価機能は、エージェントの Instructions（指示）に変数を定義した後にのみ使用できます。評価については、このラボのボーナスセクションで詳しく説明します。

---

## ステップ 2：エージェントを作成する

では、Zava の Cora エージェントを作成しましょう。  

**Agent Builder** で **+ New Agent** を選択します。  
**Agent name** フィールドに **Cora** と入力します。  
**Model** には **gpt-4o (via Microsoft Foundry)** インスタンスを選択します。

![Agent Basic Information](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/agent-basic-information.png)

---

## ステップ 3：エージェントの指示を設定する

前のセクションで Model Playground において実施したのと同様に、ここではシステムプロンプトを通じてエージェントの動作を定義します。

> [!TIP]
> Agent Builder には、タスクの説明をもとに LLM が自動的に指示を生成してくれる **Generate** 機能があります。  
> エージェントの指示を書くことが難しい場合に便利です。  
> ![Generate Agent Instruction](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/generate-agent-instruction.png)

この演習では、[前のセクション](./03_Model_Augmentation.md)で使用したものと同様の指示を使用します。

```
# **Zava 営業・在庫エージェント - システム指示**

## 1. 役割とコンテキスト

あなたは **Zava**（DIY 小売業者）の社内アシスタント **Cora** です。  
店舗マネージャーおよび本社スタッフの売上分析と在庫管理をサポートします。

* **トーン：** 専門的で、正確で、役に立つ姿勢。

* **会計年度（FY）：** 毎年 **7 月 1 日** 開始  
  * Q1：7〜9 月 | Q2：10〜12 月 | Q3：1〜3 月 | Q4：4〜6 月

* **日付処理：**「先月」「Q1」などの相対的な日付は、データベースクエリ用に常に ISO 形式（YYYY-MM-DD）に変換して使用します。

---

## 2. ツール使用戦略（ルーター）

ユーザーの意図を分析して、適切なツールフローを選択してください。

### A. 製品探索（定性的リクエスト）

* **トリガー：** 製品の特徴・説明・用途・曖昧な名前のリクエスト（例：「防水照明」「コンクリート用ドリル」）
* **アクション：** 必ず `semantic_search_products` を最初に使用します。
* **制限：** 製品の説明や名前の検索に SQL は**絶対に使用しないこと。**

---

### B. 売上・データ分析（定量的リクエスト）

* **トリガー：** 売上・販売数量・上位店舗・集計指標のリクエスト
* **アクション：** `execute_sales_query` を使用
* **要件：** 時間に関するクエリの場合（例：「先月の売上」）、正確な日付範囲を計算するために先に `get_current_utc_date` を呼び出すこと。

---

### C. 在庫・業務（読み取り/書き込み）

* **トリガー：** 在庫レベルの照会または在庫移動のリクエスト

* **ワークフロー：**

  1. **識別：** 製品 ID が不明な場合は `semantic_search_products` を使用
  2. **確認：** `get_stock_level_by_product_id` で在庫および内部 store_id を確認
  3. **確認リクエスト（重要）：**  
     在庫移動リクエストの際は必ず一時停止し、以下のように確認する：
     > 「確認をお願いします：[製品名] [数量] 個を [店舗 A] から [店舗 B] に移動してよろしいですか？」
  4. **実行：** ユーザーの明示的な確認後にのみ `transfer_stock` を呼び出す

---

## 3. コンテンツ制限とセキュリティ

* **書き込み保護：** 現在の会話ターンでのユーザーの明示的な確認なしに `transfer_stock` を実行しないこと
* **ID 非公開：** 内部的には store_id、product_id の使用は可能だが、エンドユーザーへの応答では絶対に開示しないこと
* **ハルシネーション禁止：** ツールがデータを返さない場合は  
  > 「そのリクエストに該当するデータが見つかりませんでした。」  
  と応答し、任意の情報を生成しないこと
* **スコープ外のリクエスト：**
  > 「Zava の売上・在庫・製品データに関連する業務のみサポートできます。その他のトピックについては IT サポートチームにお問い合わせください。」

---

## 4. 応答ガイドライン

* **形式：** 製品リストや売上データは Markdown の表形式を使用
* **結果なしの処理：**
  * 意味検索失敗の場合：  
    > 「その説明に一致する製品が見つかりませんでした。」
  * 売上データなしの場合：  
    > 「その条件に対する売上記録がありません。」
* **言語：** ユーザーの言語で応答
* **曖昧さの処理：** 明確でない場合は推測せず質問すること

---

## 5. 質問例（最大 10 件を提案）

* 先月最も売れたカテゴリは何ですか？（オンライン vs オフライン）
* 2024 年度 Q2 の総売上はいくらですか？
* 現在ブレーカーの在庫が不足している店舗はどこですか？
* 「Pro-Series Hammer Drill」の在庫を全店舗で確認してください
* 今月、全米店舗で売上上位 10 製品は何ですか？
* ある店舗から別の店舗へ「Pro-Series Hammer Drill」を 5 個移動
* 先月のオンラインカテゴリ別の売上は？
* 前月比で返品が異常に多い店舗はどこですか？

---

## 6. 実装上の注意事項

* **作業順序：** 日付確認 → 検索/クエリ → 形式化
* **制限：** すべての SQL クエリはデフォルト `LIMIT 20`
* **曖昧な検索結果：** 類似度スコアが低い場合は次のフレーズで開始：
  > 「検索結果から最も可能性の高い製品候補は以下のとおりです。」
```

このように、店舗運営（売上分析・在庫確認・安全な在庫移動）に関する明確な指示を追加しました。  
ただし、まだ Cora に実際の売上・在庫データへのアクセス権は付与していません。次のステップで設定します。

---

## ステップ 4：MCP サーバーを起動する

> [!NOTE]  
> [Model Context Protocol（MCP）](https://modelcontextprotocol.io/docs/getting-started/intro)は、LLM と外部ツール、アプリケーション、データソース間の通信を標準化する強力なフレームワークです。

前の「モデルの強化」演習では、ファイル添付を通じて静的データを提供しました。  
しかし実際の店舗運営には、リアルタイムで変化する売上・在庫データが必要です。

そのため、以下の 2 つの MCP サーバーを Cora に接続します。

* **Sales Analysis MCP サーバー**（売上指標＋製品のセマンティック検索）
* **Inventory MCP サーバー**（在庫照会＋安全な在庫移動）

Visual Studio Code で **F5 を押して MCP サーバーを起動**し、両サーバーが初期化されるまで待ちます。  
各サーバーごとに新しいターミナルウィンドウが開き、`Uvicorn is running on port XXXX` というメッセージが表示されれば正常に起動しています。

![MCP Servers running](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/mcp_servers_running.png)

> [!TIP]
> VS Code の **Run and Debug** タブで上部の緑色の実行ボタンをクリックして起動することもできます。

その後、`./.vscode/mcp.json` ファイルに移動し、各 Zava MCP サーバー名の上にある *Start* ボタンをクリックします。

> [!WARNING]
> GitHub Copilot Chat を以前に使用していた場合、**Restart** ボタンが表示されることがあります。その場合は Restart をクリックして、Foundry Toolkit がすでに実行中の MCP サーバーに接続できるようにしてください。

---

## ステップ 5：売上 MCP ツールをエージェントに追加する

Agent Builder に戻り、**TOOL** の横にある **+** アイコンを選択します。

**MCP Server → Use Tools Added in Visual Studio Code** を選択します。

**Edit Tool List** をクリックして、以下の 4 つのツールを選択します。

- `mcp_zava-sales-an_semantic_search_products`
- `mcp_zava-sales-an_execute_sales_query`
- `mcp_zava-sales-an_get_database_schema`
- `mcp_zava-sales-an_get_current_utc_date`

**OK** をクリックします。

> [!NOTE]
> Sales Analysis MCP サーバーが実行中でないと、ツールリストに表示されません。

---

## ステップ 6：エージェントで売上クエリをテストする

Agent Builder 右側のチャットパネルでブレーカーの画像を添付してから、以下のプロンプトを入力します。

```
I'm the store manager. Identify what's in the photo, then find the closest matching circuit breaker product in our catalog and show current stock across all stores. 
```

ツールの呼び出しが必要な場合は、VS Code で実行の承認を求めるメッセージが表示されます。各呼び出しに対して **Yes** を選択します。

モデルは非決定的であるため、応答は毎回異なる場合があります。

続いて、以下の質問もテストしてみましょう。

```
What were the sales by store for the last quarter
```

```
What are our top 3 selling products last year
```

---

## ステップ 7：在庫 MCP ツールを追加する

Agent Builder で再び **Tools → + → MCP Server → Use Tools Added in Visual Studio Code** を選択します。

上部のチェックボックスをオフにして全選択を解除した後：

1. 検索欄に **invent** と入力
2. 以下の 2 つのツールを選択：
   - `mcp_zava-inventor_get_stock_level_by_product_id`
   - `mcp_zava-inventor_transfer_stock`
3. **OK** をクリック

> [!NOTE]
> Inventory MCP サーバーが実行中である必要があります。

---

## ステップ 8：在庫確認と移動のテスト

以下のようなリクエストでテストしてみましょう。

```
Transfer 5 units of the Single Pole Circuit Breaker 20A from a store with surplus stock to the online store.
```

エージェントは移動実行前に必ず確認を求めるはずです。  
確認後、在庫レベルを再度照会して移動が成功したか検証してください。

追加テストの例：

```
What was the total revenue last month, split by online vs physical stores?
```

```
Which stores have low stock on circuit breakers right now?
```

---

## まとめ

- Agent Builder は、設定とテストを分離した 2 パネルインターフェースを提供します。
- 明確な指示により、エージェントの性格・会話スタイル・応答パターンが一貫したものになります。
- MCP サーバーは、静的ファイルの添付よりも効果的に外部データとツールを連携させます。
- MCP ツールの統合により、エージェントはリアルタイムの売上・在庫照会と、明示的な確認に基づく業務アクションの実行が可能になります。

次のセクションに進むには **Next** をクリックしてください。

===

# コードへの移行

このセクションでは、Foundry Toolkit で作成したエージェントをコードベースのワークフローに移行する方法を学びます。

Foundry Toolkit は、Agent Builder で作成したエージェントのコードを自動生成します。希望する SDK とプログラミング言語を選択でき、生成されたコードファイルを自分のアプリケーションに統合できます。

---

## ステップ 1：コードを生成する

Agent Builder 画面の左下にスクロールして **View Code** を選択します。

![View code button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/view-code.png)

SDK（例：*Microsoft Agent Framework*）とプログラミング言語（例：*Python*）を選択するよう求められたら、希望するオプションを選択します。  

新しいファイルが生成されたら、ワークスペースに保存します。（`src/cora-app.py`）

---

## ステップ 2：コードを確認する

スクリプトを実行する前に、ファイルの内容を確認してください。実行前に修正が必要なプレースホルダーが含まれている可能性があります。  

スクリプトのロジックを理解するのに助けが必要な場合は、GitHub Copilot Chat の **Ask** モードを使用できます。

Visual Studio Code 上部の **Toggle Chat** アイコンをクリックして GitHub Copilot Chat にアクセスします。

![Toggle chat button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/toggle-chat.png)

> [!NOTE]
> Copilot を初めて使用する際にログインを求められた場合は、**Sign-in → Continue with GitHub** を選択してください。  
> その後、GitHub ログインページに移動したら、GitHub にホストされたモデルにアクセスする際に使用した GitHub Enterprise アカウントでログインし、**Continue** をクリックします。

生成されたコードファイルを `src/cora-app.py` として保存し、GitHub Copilot Chat がそのファイルをコンテキストとして使用できるよう、ファイルをアクティブな状態に保ってください。  
または、Copilot Chat のプロンプトでファイル名を直接参照することもできます。

![GitHub Copilot Chat in Ask mode.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/ghcp-ask-mode.png)

> [!NOTE]
> ファイル名の横に「+」アイコンが表示されている場合、Copilot がそのファイルをコンテキストとして提案していますが、まだ追加されていない状態です。「+」アイコンをクリックしてファイルをコンテキストに追加してください。
>
> ![Suggested file as context](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/suggested_file_context.png)

例えば、以下のようなプロンプトを入力してみてください。

```
Explain what's happening in this script.
```

コードを修正する必要がある場合は、**Agent** モードに切り替えて変更をリクエストできます。  
ファイルが変更される前に、変更内容の承認を求められます。

---

## （任意）ボーナス

コードを実際に実行するには、ファイルを保存した後、ファイル上部のコメントに記載されているガイドに従ってください。  
選択した SDK とプログラミング言語によって手順が異なる場合があります。

例えば、**Microsoft Agent Framework** SDK と **Python** を選択した場合は、以下の手順に従ってください。

### 1. MCP サーバーツールの設定部分を見つける

コードファイルで MCP サーバーツールを設定している部分を探します。以下のようなコードがあるはずです。

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

### 2. プレースホルダーを修正する

上記のプレースホルダーを、このワークショップで使用した 2 つの MCP サーバー（売上分析および在庫管理）を指すように変更します。

このワークショップでは、以下のローカルアドレスでサーバーが実行されています。

- `http://localhost:8004/mcp/` (Sales Analysis MCP server)
- `http://localhost:8005/mcp/` (Inventory MCP server)

修正後の設定例は次のとおりです。

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
> 選択した SDK によっては、ローカルの stdio プロセスの代わりに HTTP MCP サーバー URL で設定する必要がある場合があります。

---

### 3. 新しいターミナルを開く

Visual Studio Code 上部メニューから **Terminal → New Terminal** を選択して新しいターミナルを開きます。

### 4. 必要な依存関係をインストールする

```
pip install agent-framework --pre
```

### 5. Azure 認証

```
az login
```

ブラウザウィンドウが開いたら、認証コードを入力してログインプロセスを完了します。  
ターミナルに戻った後、Enter キーを押して Azure サブスクリプションの選択を確認します。

コードファイルが保存されているディレクトリに移動します。

```
cd src
```

以下のコマンドでスクリプトを実行します。

```
python cora-app.py
```

> [!NOTE]
> スクリプトを実行する前に MCP サーバーが実行中であることを確認してください。  
> 前のステップを正常に完了していれば、MCP サーバーはすでにローカル環境で実行中のはずです。

GitHub Copilot Chat の **Agent モード**を使用して、Cora エージェントのインターフェースファイルの生成をサポートしてもらうことができます。  
また、Copilot にエージェントスクリプトをアプリインターフェースと統合するよう依頼して、機能するエージェントプロトタイプを構築することもできます。

---

## まとめ

- Agent Builder は、さまざまなプログラミング言語および SDK に対応したエージェントコードを自動生成することで、プロトタイプから本番環境への移行を簡素化します。

- 生成されたコードには実行前に修正が必要なプレースホルダーが含まれている場合があるため、開発者はこれを理解したうえで要件に合わせて調整する必要があります。

- GitHub Copilot Chat の Ask モードと Agent モードを活用することで、生成されたコードの理解や、UI コンポーネントなどの追加アプリケーション要素の迅速な実装が可能になります。

次の演習ステップに進むには **Next** をクリックしてください。
 

===

# ボーナス：エージェントの応答を手動で評価する

> [!NOTE]
> このセクションは、演習時間に余裕がある場合に実施できるボーナスセクションです。時間が足りない場合は、自宅で自分のペースで完了しても構いません。

このセクションでは、エージェントの応答データセットを**手動で評価**する方法を学びます。手動評価とは、人間が直接 LLM の出力品質を判断する方式です。実際には、生成された応答を読み、ルーブリックや簡単な基準に従って正確性・関連性・明確さ、または総合的な品質（「良い」/「悪い」）を評価します。Agent Builder を使用することで、このような手動評価を通じてエージェントのパフォーマンスを確認できます。

---

## ステップ 1：エージェントの指示に変数を追加する

Agent Builder の **Evaluation** 機能を使用するには、エージェントの **Instructions** に変数が含まれている必要があります。  
変数は、エージェントの指示やユーザープロンプトのコンテキストを変更できる値であり、エージェントの全体的な目的に関連している必要があります。変数は二重波括弧で囲んで表記します（例：`{{変数}}`）。

Cora エージェントの目的は店舗運営と本社レポーティングをサポートすることなので、運営コンテキストを変更する変数を使用することが適切です。この例では `{{store}}` 変数を使用します。  

**Instructions** を以下のように修正します。

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
> モデルが gpt-4o（via Microsoft Foundry）に設定されていることを確認してください。

すべての変数は Agent Builder の **Variables** セクションに保存されます。以下のスクリーンショットにエラーメッセージが表示されていても無視してください。変数の値は Evaluation タブで設定します。

![Agent variables.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/agent-variables.png)

この機能はどのように動作するのでしょうか？

例えば `{{store}}` の値として `Seattle` を設定したとします。  
ユーザープロンプトが実行されると、**Instructions** が動的に更新され、`{{store}}` の部分に `Seattle` が反映されます。

例：

> "You are Cora, Zava's internal assistant. You help store managers and head office staff analyze sales and manage inventory, tailored to the needs of the Seattle location."

では、評価データを実行して実際に確認してみましょう。

---

## ステップ 2：データを追加する

Agent Builder で **Evaluation** タブに移動します。  
評価を実行するには **User Query** と **{{store}}** の値が両方必要です。

- **User Query**：ユーザーがエージェントに送るプロンプト  
- **{{store}}**：変数に渡す値  

> [!NOTE]
> `+ Add an Empty Row` をクリックしないと、`{{store}}` 変数がテーブルのヘッダーに表示されません。

![Evaluation table.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/evaluation-table.png)

データを追加する方法はいくつかあります。

> [!TIP]
> Evaluation セクションを全画面表示にするには、ゴミ箱アイコンの隣にある **Expand to Full Screen** アイコンをクリックしてください。

---

### 1) 手動でデータを追加する

**Evaluation** タブで空の行を追加した後、**User Query** と `{{store}}` のセルに直接入力できます。

例：

User Query  
{{store}}

先月の売上ベースで上位 3 つのカテゴリは何ですか？  
Seattle  

今週、在庫不足のリスクがある製品は何ですか？  
Redmond  

先月のオンライン売上とオフライン売上の実績をまとめてください。  
Head Office  

今週末のプロモーション用ブレーカーの在庫は十分ですか？  
Bellevue  

> [!TIP]
> **Add an Empty Row** ボタンで行を追加した後、セルをダブルクリックして編集してください。

---

### 2) データを生成する（Generate Data）

データ生成が必要な場合は、**Generate Data** 機能を使用して最大 10 件の合成データを生成できます。  

合成データとは、実際のデータを模倣して人工的に生成されたデータです。  
この機能は、Generation Logic を入力として受け取り、**User Query** と `{{store}}` のペアを生成する LLM を使用します。

デフォルトでは、エージェントの Instructions をもとに Generation Logic が自動生成されますが、必要に応じて修正できます。

![Generate data.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/generate-data.png)

**Rows of Data to Generate** の値を入力し、**Generation Logic** を修正して **Generate** をクリックすると、データセットが生成されて評価テーブルに表示されます。

---

### 3) データセットをインポートする（Import）

大量の **User Query** と `{{store}}` のペアを独自に作成した場合は、CSV ファイルとして Agent Builder にアップロードできます。

CSV ファイルの形式：

User Query  
{{store}}

先月の売上ベースで上位 3 つのカテゴリは何ですか？  
Seattle  

今週、在庫不足のリスクがある製品は何ですか？  
Redmond  

先月のオンライン売上とオフライン売上の実績をまとめてください。  
Head Office  

今週末のプロモーション用ブレーカーの在庫は十分ですか？  
Bellevue  

**User Query** と `{{store}}` は必ずヘッダーである必要があります。

**Import** アイコン（上向き矢印の形）をクリックして CSV ファイルをアップロードできます。

![Import dataset.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/import-dataset.png)

各オプションを実際に試してみてください！  
以降の演習は**手動データ追加**方式を基準に進めます。

---

## ステップ 3：エージェントのパフォーマンスを評価する

データセットの準備ができたら、各行を個別に実行するか、複数行を同時に実行できます。  

すべての行を選択するには、ヘッダー行のチェックボックスを選択します。  
選択した行を実行するには、**Run Response** アイコン（再生ボタン）をクリックします。

![Run button.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/run-eval.png)

モデルは各 **User Query** と `{{store}}` の組み合わせに対して応答を生成します。  
応答が生成されたら結果を確認し、**Manual** 列で 👍 または 👎 アイコンを選択します。

![Manual evaluation.](https://raw.githubusercontent.com/microsoft/aitour26-WRK540b-prototype-agents-with-the-ai-toolkit-and-model-context-protocol/main/img/manual-evaluation.png)

どのように判断すればよいでしょうか？

- 👍 **Thumbs Up**：応答が正確で、関連性が高く、明確で、実際に役に立つ場合  
- 👎 **Thumbs Down**：応答が不正確、不完全、分かりにくい、または的外れで役に立たない場合  

簡単に言えば、自分自身にこう問いかけてください。

**「この結果は自分が必要としていたものに応えているか？」**  
→ そうなら 👍、そうでなければ 👎 を選択してください。

---

## まとめ

- `{{store}}` のような変数を追加することで、エージェントの核心的な目的を維持しながら、さまざまな運営コンテキストでの体系的なテストが可能になります。

- Agent Builder は、手動入力・合成データ生成・CSV インポートのすべてをサポートしており、柔軟な評価データセットの構成が可能です。

- 👍/👎 ベースの人間による評価を通じて、自動化された指標を超えた正確性・関連性・有用性の総合的な判断ができます。

---

# まとめ

この演習では以下を学びました。

- ビジネスシナリオに適したモデルを探索・比較する方法  
- より正確で根拠のある応答を得るためにプロンプトとデータを活用する方法  
- MCP（Model Context Protocol）を通じてモデルとツールを組み合わせて社内向けエージェントをプロトタイピングする方法  
- さらなるカスタマイズと実装のためにエージェントコードを抽出する方法  

また、Visual Studio Code の Foundry Toolkit を活用して AI ベースのアプリケーションを効率的に開発する実践的な経験を積みました。

---

## 次のステップ

AI エージェントを本番環境にデプロイする前に、以下の点を検討してください。

- **Azure にホストされたモデル：**  
  本番環境では Azure にホストされたモデルの使用をお勧めします。より優れたパフォーマンス、安定性、エンタープライズレベルのコンプライアンスを提供します。  
  Microsoft Foundry Models カタログで確認できます：  
  https://ai.azure.com/catalog  

- **評価：**  
  エージェントをデプロイする前に、正確性・関連性・安全性の観点から十分に評価してください。自動テストと人間による評価を組み合わせることをお勧めします。  
  関連ドキュメント：  
  https://code.visualstudio.com/docs/intelligentapps/evaluation  

- **デプロイ：**  
  Microsoft Agent Framework ベースの Python アプリケーション、Microsoft Foundry モデル、MCP サーバーを含む構成は、Azure Container Apps または Azure Kubernetes Service（AKS）にデプロイできます。これらのサービスは、本番ワークロードに必要なスケーラビリティと安定性を提供します。

- **モニタリング：**  
  デプロイ後は、実際の使用環境でエージェントのパフォーマンスを継続的に監視してください。ログとアラートシステムを設定して異常な動作を検出してください。Microsoft Foundry の可観測性（Observability）機能も役立ちます。  
  https://learn.microsoft.com/azure/ai-foundry/how-to/monitor-applications  

- **継続的な改善：**  
  AI エージェントは継続的に改善できます。ユーザーフィードバックとインタラクションデータを分析して、モデル・プロンプト・ツールを定期的に更新してください。

---

## 自宅での実践

この演習はいつでも再度実施できます。  
完全な演習ガイドは以下の GitHub リポジトリで確認できます。

https://github.com/microsoft/aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol

---