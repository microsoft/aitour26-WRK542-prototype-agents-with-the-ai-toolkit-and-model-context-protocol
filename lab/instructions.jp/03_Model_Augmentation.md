# モデル拡張: コンテキストを強化して性能を高める

このセクションでは、プロンプトエンジニアリングとコンテキスト データを使って、選択したモデルの性能とユースケース適合度を高める方法を学びます。これは、AI モデルをビジネス要件に合わせてチューニングするうえで重要なステップです。

## Step 1: システムメッセージを作る

システムメッセージは、モデルの振る舞いとタスク文脈を規定するプロンプトの重要要素です。モデルに「役割」と「要求事項」を理解させるのに役立ちます。効果的なシステムメッセージを作るためのポイントは次のとおりです。

1. **明確かつ簡潔に**: 目的と期待する結果を明確にし、曖昧さを避けます。

2. **コンテキストを提供**: 正確で文脈に沿った応答を生成できるよう、背景情報を含めます。

3. **期待値を明示**: 応答の形式、長さ、スタイルなど、制約や要件を指定します。

4. **複雑な指示は分解**: タスクが複雑なら、ステップごとの指示に分けてモデルをガイドします。

まずは、Playground のチャット履歴をクリアして、まっさらな状態から始めます。画面左上の **New Playground** をクリックしてください。

![New Playground](../../img/new_playground.png)

Playground 右ペインの **System Prompt** フィールドに、次のシステムメッセージを入力します。

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

Always respond in Japanese.
```

![System Prompt](../../img/system_prompt.png)

このメッセージには次が含まれています。
- アシスタントの **役割と責務**（社内向けの店舗運営＋本部分析）
- **応答スタイル**（簡潔・実行可能・確認優先）
- 運用アクションのための **安全ガードレール**（在庫移動は必ず明示的な確認）

## Step 2: マルチモーダル入力でシステムメッセージをテストする

システムプロンプトを設定したので、マルチモーダルなユーザー プロンプトで試します。Playground のチャットで画像添付アイコンをクリックし、会話コンテキストに画像をアップロードします。次のパスにあるブレーカー画像を選択します。

```    
C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\instructions\circuit_breaker.png
```

次のユーザー プロンプトと組み合わせます。

```
Here’s a photo from the store floor. What is this component, and what details should I capture (e.g., amperage, pole type) before searching our catalog and checking stock?
```

紙飛行機アイコンをクリックして実行します。
モデルが画像を解析し、説明と、カタログ検索／在庫確認に必要な情報の提案を返します。応答がシステムメッセージの期待（簡潔さ、確認優先など）に沿っているか確認してください。

次に、Zava の業務と無関係な質問を試します。次のプロンプトを入力します。

```
What’s the weather like in Tokyo today? 
```

モデルは、Zava 関連の問い合わせのみ支援できると丁寧に伝えるはずです。これは、システムメッセージのガイドラインに従えることの確認になります。

## Step 3: グラウンディング データを追加する

システムメッセージに加えて、コンテキスト データを与えることで、モデルの関連性と正確性を大きく向上できます。コンテキスト データには、事業情報、商品情報、サービス情報など、シナリオ理解に役立つ内容を含めます。

このユースケースでは、Zava の商品カタログに関するコンテキストを与え、社内の質問に対して商品情報をでっち上げないようにします。

グラウンディング データを追加するために、Playground の **ファイル添付** 機能を使います。これにより、モデルが参照できるドキュメントをアップロードできます。

アップロードするのは、Zava 商品カタログの一部を含む JSON ファイルです。内容を確認したい場合は、**data** フォルダーにある **zava_product_catalog.json** を開いてください。

1. Playground に戻り、プロンプト入力欄のファイル添付アイコンをクリックします。
![File attachment icon](../../img/file_attachment_icon.png)
2. `/data/` ディレクトリから `zava_product_catalog.json` を選択します。

> [!TIP]
> 開くウィンドウで、データ ディレクトリは次のパスにあります。
> ```
>C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\data
> ```

![Uploading Grounding Data File](../../img/uploading_grounding_data_file.png)

3. アップロードが完了すると、プロンプト入力欄の下に添付として表示されます。
4. 次のプロンプトを入力します。

```
From the attached Zava product catalog, suggest a circuit breaker option that would commonly be used for a 15-amp household circuit, and explain what you would verify before recommending it.
```

モデルはアップロードされた商品カタログを参照し、ブレーカーの要件に合う候補を根拠付きで提案します。

裏側では、添付データがプロンプト コンテキストに自動的に含まれるため、より情報に基づいた応答が可能になります。

ただし、この方法には制約があります。モデルが処理できるプロンプト コンテキストには上限があり、添付が大きいほどレイテンシとコストが増えます。大規模データや複雑なシナリオでは、現在のユーザー クエリに最も関連する情報だけをプロンプトに入れるための、より洗練された検索／取得（retrieval）メカニズムが必要です。次のセクションでこれを詳しく扱います。

## まとめ（Key Takeaways）
- 効果的なシステムメッセージは、モデルの振る舞いを制御し、適切な応答を引き出すのに不可欠
- ファイル添付によるコンテキスト付与（グラウンディング）は、モデル性能と関連性を大幅に向上できる
- マルチモーダル入力でのテストは、システムメッセージとコンテキストの有効性を検証するのに有効
- グラウンディング データは、モデル入力制限に収まるよう、関連性が高く簡潔なものにする

**Next** をクリックして、ラボの次のセクションへ進んでください。
