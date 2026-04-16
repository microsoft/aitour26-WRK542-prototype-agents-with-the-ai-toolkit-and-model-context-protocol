# コードへ移行（Migrate to Code）

このセクションでは、Foundry Toolkit で Agent Builder により作成したエージェントを、コードベースのワークフローに移行する方法を学びます。

Foundry Toolkit は、Agent Builder で作成したエージェント向けに生成コードを提供します。好みの SDK とプログラミング言語を選べます。生成されたコードを自分のアプリに統合すれば、プロトタイプから実装へスムーズに進められます。

## Step 1: コードを生成する

Agent Builder で、画面右上の **View Code** ボタンをクリックします。

![View code button.](../../img/view-code.png)

> [!NOTE]
> 前のセクションで説明したとおり、エージェントをローカルに保存している必要があります。保存していない場合、**View Code** オプションは表示されません。

表示されたら、好みのクライアント SDK（例: *Microsoft Agent Framework*）とプログラミング言語（例: *Python*）を選択します。新しいファイルが作成されたら、ワークスペースに保存します（'src/cora-app.py' 配下）。

## Step 2: コードを確認する

スクリプトを実行する前に、ファイル内容を確認してください。実行前に修正が必要なプレースホルダーが含まれている場合があります。スクリプトのロジック理解に不安がある場合は、GitHub Copilot Chat の **Ask** モードを使って確認できます。

GitHub Copilot Chat を開くには、Visual Studio Code 上部の **Toggle Chat** アイコンを選択します。

![Toggle chat button.](../../img/toggle-chat.png)

生成されたコードを 'src/cora-app.py' としてワークスペースに保存し、そのファイルをアクティブにしておきます（Copilot Chat がコンテキストとして利用できるようにするため）。または、プロンプト内でファイルを明示的に参照しても構いません。

![GitHub Copilot Chat in Ask mode.](../../img/ghcp-ask-mode.png)

> [!NOTE]
> ファイル名の横に '+' アイコンが表示されている場合、cora-app.py は Copilot Chat によりコンテキスト候補として提案されていますが、まだ追加されていません。'+' をクリックしてコンテキストに追加してください。
>
> ![Suggested file as context](../../img/suggested_file_context.png)

例えば、次のプロンプトを試します。

```
このスクリプトで何が行われているか説明してください。
```

修正が必要な場合は、**Agent** モードに切り替えて変更を依頼できます。ファイル変更を適用する前に、承認（approval）を求められます。

## （任意）Bonus

コードを実行してみたい場合は、ファイルを保存し、コード先頭のコメントに従ってください。手順は選択した SDK と言語により異なります。

例として、**Microsoft Agent Framework** SDK と **Python** を選んだ場合の手順は次のとおりです。

1. cora-app.py 内で MCP サーバー構成のセクションを見つけ、URL とポートがローカルで起動している MCP サーバーと一致していることを確認します。

2. MCPサーバーURLの修正
   
    - 接続エラーを回避するため、2箇所のURL設定を以下のように更新してください。

    - 修正内容: 末尾のスラッシュ（/）を必ず削除してください。

    - 正しい形式: http://localhost:PORT_NUMBER/mcp

        ![MCP Server URL fix](../../img/mcp_url_fix.png)

3. Visual Studio Code で **Terminal** -> **New Terminal** を選択して新しいターミナルを開きます。

4. 次を実行して依存関係をインストールします。

```
pip install --no-deps agent-framework==1.0.0rc3 agent-framework-core==1.0.0rc3 agent-framework-azure-ai==1.0.0rc3
```

4. Azure に認証します。

```
az login
```

ブラウザー ウィンドウを開いてコード入力を求められます。認証が完了してターミナルに戻ったら、サブスクリプション選択の確認として **Enter** を押します。

5. コード ファイルを保存したディレクトリへ移動します。

```
cd src
```

6. スクリプトを実行します。

```
python cora-app.py
```

> [!TIP]
> スクリプト内のユーザー入力を変えてテストすると、さまざまなシナリオでの挙動を確認できます。`USER_INPUTS` 配列の定義を見つけ、入力値を変更してください。例:

```
USER_INPUTS = [
    "What are the top 5 best-selling products in the last month?",
    "Which stores have low stock on circuit breakers right now?"
]
```

> [!NOTE]
> スクリプト実行前に MCP サーバーが起動している必要があります。前のセクションの手順どおりに進めていれば、MCP サーバーはローカルで起動しているはずです。

GitHub Copilot Chat の Agent モードを使って、Cora エージェント用の UI ファイル作成を依頼するのも良いでしょう。また、エージェント スクリプトをアプリ UI に統合して、動作するプロトタイプへ仕上げる依頼もできます。

## まとめ（Key Takeaways）

- Agent Builder は複数言語／複数 SDK 向けにエージェントのコードを自動生成し、プロトタイプから実装へ移行しやすい
- 生成コードには実行前に修正が必要なプレースホルダーが含まれることがあり、ロジック理解と調整が必要
- GitHub Copilot Chat の Ask／Agent モードは、生成コード理解や UI などの追加コンポーネント作成に有効

**Next** をクリックして、ラボの次のセクションへ進んでください。
