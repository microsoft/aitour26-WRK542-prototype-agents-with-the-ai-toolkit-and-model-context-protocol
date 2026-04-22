# はじめに（セットアップ）

> [!TIP]
> **Foundry Toolkit** とは？ [The Foundry Toolkit](https://code.visualstudio.com/docs/intelligentapps/overview) は Visual Studio Code の拡張機能で、さまざまな AI モデルやサービスにアクセスして操作するための統合 UI を提供します。複数プロバイダー（プロプライエタリ／オープンソース）にまたがるモデルを、GitHub、Microsoft Foundry、ローカルなど複数のホスティング形態で探索・比較・利用できます。Foundry Toolkit を使うことで、モデル選定・プロンプトエンジニアリング・エージェントの試作／テストまでをエディター内で完結させ、生成 AI 開発のワークフローを効率化できます。

## Windows にサインイン

最初に、Resources タブの Skillable VM 名の下にある資格情報を使って、ラボの仮想マシンにログインします。

![VM login credentials](../../img/vm_login_credentials.png)

> [!TIP]
> **Skillable は初めてですか？** 「T」アイコン（例: +++Admin+++）は、VM 内で現在のカーソル位置にワンクリックで自動入力される値を示します。入力の手間を減らし、入力ミスも抑えられます。
> また、必要に応じて画像をクリックして拡大表示できます。

## GitHub にログイン

このワークショップでは、Foundry Toolkit の Model Catalog にある GitHub ホストモデルへアクセスしたり、Visual Studio Code の GitHub Copilot 機能を使うために、GitHub Enterprise（GHE）アカウントを利用します。

以下の手順で、提供された GitHub Enterprise（GHE）アカウントでサインインします。

1. タスクバーから Microsoft Edge を開きます。[GHE サインインページ](https://github.com/enterprises/skillable-events) がすでに開かれたタブが表示されます。

2. **Continue** をクリックし、次の資格情報でサインインします。
   -  Username: +++@lab.CloudPortalCredential(User1).Username+++
   -  TAP: +++@lab.CloudPortalCredential(User1).TAP+++

*Skillable Events* GitHub org の **Overview** ページが表示されれば、ログインは成功です。ブラウザータブは閉じずに最小化しておき、次に Visual Studio Code でワークショップ環境を開きます。

## Visual Studio Code でワークショップ環境を開く

以下の手順で Visual Studio Code でワークショップ環境を開きます。
タスクバー下部のターミナル アイコンをクリックして、ターミナルを開きます。

![Open terminal](../../img/open_terminal.png)

次のコマンド ブロックをターミナルへコピー＆ペーストして **Enter** を押してください。このコマンドは、ワークショップ リポジトリを更新し、Python 仮想環境を有効化し、プロジェクトを VS Code で開きます。

```powershell
; cd $HOME\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\ `
; git pull `
; Remove-Item -Recurse -Force .git `
; .\.venv\Scripts\activate `
; $env:OTEL_SDK_DISABLED="true" `
; code .
```

> [!NOTE]
> ターミナルに複数行を貼り付ける警告が表示されます。**Paste anyway** をクリックして続行してください。

## Azure に認証

Visual Studio Code では、Foundry Toolkit 拡張機能がすでにインストールされているはずです。クリックして Foundry Toolkit のサイドバーを開きます。

![Installed extensions](../../img/installed_extensions.png)

> [!TIP]
> Foundry Toolkit アイコンが見当たらない場合、サイドバー下部の省略記号（...）をクリックして、インストール済み拡張機能の一覧を表示してください。

> [!WARNING]
> ラボ手順の一貫性を保ち、予期しない問題を避けるため、VS Code 拡張機能の自動更新は無効化されています。ラボ中は拡張機能を更新しないでください。

次に、**Set Default Project** -> **Sign in to Azure** をクリックします。

<!--![Set Default Project](../../img/set_default_project.png)-->

Azure ログインの確認ポップアップが表示されるので、**Allow** をクリックします。

![Azure Login Popup](../../img/azure_login_popup.png)

続いて、ログイン手続きを完了するためのウィンドウにリダイレクトされます。次の資格情報を入力します。
-  Email: +++@lab.CloudPortalCredential(User1).Username+++
-  TAP: +++@lab.CloudPortalCredential(User1).TAP+++

> [!NOTE]
> デバイス上のすべてのデスクトップ アプリと Web サイトに自動サインインを許可するか確認されます。**Yes** をクリックして続行してください。

VS Code に戻ると、使用する Foundry プロジェクトの選択を求められます。このワークショップ用に事前デプロイされているプロジェクト（1 つだけ）を選択してください。

![Select Project](../../img/select_project.png)

ログインが成功すると、**My resources** の下にプロジェクトが表示されます。ここから、モデル、エージェント、ツールなどのリソースへアクセスして管理できます。

## GitHub Copilot の AI 機能を有効化

このワークショップでは、開発タスクを支援するために VS Code の GitHub Copilot 機能も利用します。GitHub Copilot を有効化するには、先ほど Microsoft Edge で使用したのと同じ GitHub Enterprise（GHE）アカウントでサインインする必要があります。以下の手順でサインインしてください。

1. VS Code ウィンドウ右下の **Copilot** アイコン（"Signed out" と表示）をクリックします。
1. **Sign in to use AI features** -> **Continue with GitHub** をクリックします。

    ![GitHub Copilot Sign In](../../img/github_copilot_sign_in.png)

    次に「Continue with GitHub」を選択します

    ![Select GitHub](../../img/sign-into-github.png)

1. 新しいブラウザー タブが開き、VS Code の認可が求められます。**Continue with GitHub** をクリックし、同じ GHE アカウントでサインインします。次の画面で **Authorize Visual Studio Code** をクリックします。

    ![Authorize GitHub Copilot](../../img/authorize_github_copilot.png)

    次に「Authorize Visual-Studio-Code」を選択します

    ![Authorize VS Code](../../img/authorize-vs-code.png)

1. 続行するには Open を選択します

<!-- ## Got issues when logging in with GitHub?

> [!NOTE]
> If you are properly logged in with the GHE account as per previous step, please ignore this section and move to the next one.

If you encounter issues when logging in with the given GHE account, you can always use your own, by following the steps below:

1. Navigate to the [GitHub repo](https://aka.ms/msignite25-lab512) hosting the lab code and resources. 

    > [!TIP]
    > Click the Star button in the top right corner, this will help you easily find it later.

2. To launch a codespace, you need a **GitHub account**. 

    > [!NOTE]
    > If you already have a GitHub account, you can move to step 3 directly.

    To create one, click on the **Sign up** button and follow the instructions below:
    - In the new window, enter a personal email address, create a password, and choose a username.
    - Select your Country/Region and agree to the terms of service.
    - Click on the **Create account** button and wait for the verification email to arrive in your inbox.

    ![GitHub Account Sign Up](../../img/github_signup.png)

    - Copy the verification code from the email and paste it into the verification field on the GitHub website. Then click on **Continue**.
    - Once the account is created, you'll be redirected back to the GitHub repo page and you'll see a green banner at the top, like the one in the screenshot below.

    ![GitHub Repo Banner](../../img/github_repo_banner.png)

> [!WARNING]
> If your personal GitHub account is a free-tier one, you will have some limitations in the range of GitHub-hosted models you can access in the Foundry Toolkit Model Catalog. For example, you won't be able to use the GPT-5 family of models. You can still proceed with the lab using available models (recommended: OpenAI gpt-4.1).

3. Click on **Sign in** and enter your GitHub credentials to log in. If you just created your account, use the username and password you set during the sign-up process. -->


## 準備完了

これで、Visual Studio Code 上で Foundry Toolkit と Microsoft Foundry ホストモデルを使うためのセットアップは完了です。次は Model Catalog を探索し、モデルと対話するところから始めます。
**Next** をクリックして、ラボの次のセクションへ進んでください。
