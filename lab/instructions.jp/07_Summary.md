# まとめ

このラボでは、次のことを学びました。

- モデルを探索・比較し、ビジネス シナリオに最適なモデルを選定する
- プロンプトとデータでモデルを拡張し、より正確で根拠のある（grounded）応答を得る
- MCP（Model Context Protocol）経由でツールを接続し、モデル＋指示＋ツールを組み合わせて社内向けエージェントを試作する
- エージェントのコードを抽出し、追加のカスタマイズやデプロイに進める

この一連の流れを通じて、VS Code の Foundry Toolkit をハンズオンで体験しました。Foundry Toolkit は、AI を活用したアプリケーション開発を効率化するよう設計されています。

## 次のステップ

AI エージェント開発を進め、将来的に本番環境へデプロイすることを考える際に、特に重要な観点がいくつかあります。

- **Azure ホストモデル**: 本番用途では、Azure でホストされたモデルの利用が推奨されます。パフォーマンス、信頼性、エンタープライズ標準に沿ったコンプライアンス面でメリットがあります。利用可能なカタログは [Microsoft Foundry Models](https://ai.azure.com/catalog) で確認できます。
- **評価（Evaluation）**: デプロイ前に、エージェントの性能を十分に評価することが重要です。正確性、関連性、安全性を検証してください。自動テストと人手評価を組み合わせるのが効果的です。詳細は [公式ドキュメント](https://code.visualstudio.com/docs/intelligentapps/evaluation) を参照してください。
- **デプロイ（Deployment）**: デプロイ先のインフラ／プラットフォームは要件に応じて選択します。例えば、このラボで試作したような「Microsoft Agent Framework ベースの Python アプリ + Microsoft Foundry ホストモデル + MCP サーバー」の構成は、[Microsoft Foundry Hosted Agents](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents) を使ってコンテナー イメージとして Microsoft 管理の従量課金インフラへデプロイできます。
- **監視（Monitoring）**: デプロイ後は、実運用でのパフォーマンスを継続的に監視します。ログとアラートを整備し、エージェントの挙動と指標を追跡してください。Microsoft Foundry の可観測性（observability）機能が役立ちます。詳細は [公式ドキュメント](https://learn.microsoft.com/azure/ai-foundry/how-to/monitor-applications) を参照してください。
- **継続的改善（Continuous improvement）**: AI エージェントは継続的に改善できます。ユーザー フィードバックを集め、対話ログを分析して改善点を見つけましょう。モデル、プロンプト、ツールを定期的に更新し、有効性と適合性を維持します。

## 自宅で試す（Try this at home）

このラボは、あとで自分のペースで復習できます。完全な手順とリソースは、公式の [GitHub repository](https://github.com/microsoft/aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol) で確認できます。
