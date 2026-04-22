<p align="center">
<img src="img/Banner-MS-AI-Tour-26.png" alt="decorative banner" width="1200"/>
</p>

# [Microsoft AI Tour 2026](https://aitour.microsoft.com)

## 🔥WRK542: Prototype agents with Foundry Toolkit and Model Context Protocol

[![Microsoft Foundry Discord](https://dcbadge.limes.pink/api/server/Pwpvf3TWaw)](https://aka.ms/MicrosoftFoundryDiscord-AITour26)
[![Microsoft Foundry Developer Forum](https://img.shields.io/badge/GitHub-Microsoft_Foundry_Developer_Forum-blue?style=for-the-badge&logo=github&color=adff2f&logoColor=fff)](https://aka.ms/MicrosoftFoundryForum-AITour26)

If you will be delivering this session, check the [session-delivery-sources](./session-delivery-resources/) folder for slides, scripts, and other resources.

### Session Description

Learn how to build a conversational AI agent in VS Code using the Microsoft Foundry Toolkit and the Model Context Protocol (MCP). You'll explore and compare models to find the best fit for your agent, configure its instructions and enable sales analysis and product inventory management.

### 🧠 Learning Outcomes

By the end of this session, learners will be able to:

-  Explore and compare models to select the best fit for their business scenario
-  Augment models with prompts and data to get more accurate and grounded responses 
-  Prototype an agent by combining models and instructions with tools via MCP (Model Context Protocol)

### 💻 Technologies Used

1. [Foundry Toolkit for Visual Studio Code](https://code.visualstudio.com/docs/intelligentapps/overview)
1. [GitHub models](https://github.com/features/models)
1. [Microsoft Foundry Models](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/foundry-models-overview)
1. [MCP - Model Context Protocol](https://modelcontextprotocol.io/docs/getting-started/intro)

### 🔗 Session Resources
| Resources          | Links                             | Description        |
|:-------------------|:----------------------------------|:-------------------|
| Additional Resources for this session | [https://learn.microsoft.com](https://learn.microsoft.com?ocid=AITour26_resourcecenter_cnl) | Links specific to this session |

### 📚 Continued Learning Resources
| Resources          | Links                             | Description        |
|:-------------------|:----------------------------------|:-------------------|
| AI Tour 2026 Resource Center | [https://aka.ms/AITour26-Resource-Center](https://aka.ms/AITour26-Resource-Center?ocid=AITour26_resourcecenter_cnl) | Links to all repos for AI Tour 26 Sessions |
| Microsoft Foundry Community Discord | [![Microsoft Foundry Discord](https://dcbadge.limes.pink/api/server/Pwpvf3TWaw)](https://aka.ms/MicrosoftFoundryDiscord-AITour26)| Connect with the Microsoft Foundry Community! |
| Learn at AI Tour | [https://aka.ms/LearnAtAITour](https://aka.ms/LearnAtAITour?ocid=AITour26_resourcecenter_cnl) | Continue learning on Microsoft Learn |

### 🌐 Multi-Language Support

*Coming soon*

## Content Owners

<!-- TODO: Add yourself as a content owner
1. Change the src in the image tag to {your github url}.png
2. Change INSERT NAME HERE to your name
3. Change the github url in the final href to your url. -->


<table>
<tr>
    <td align="center"><a href="http://github.com/gloveboxes">
        <img src="https://github.com/gloveboxes.png" width="100px;" alt="Dave Glover"
/><br />
        <sub><b>Dave Glover (Python)
</b></sub></a><br />
            <a href="https://github.com/gloveboxes" title="talk">📢</a>
    </td>
<tr>
 <td align="center"><a href="http://github.com/carlotta94c">
        <img src="https://github.com/carlotta94c.png" width="100px;" alt="Carlotta Castelluccio"/><br />
        <sub><b>Carlotta Castelluccio</b></sub></a><br />
            <a href="https://github.com/carlotta94c" title="talk">📢</a> 
    </td>
</tr>
</table>

## 🚀 Try Azure for Free!

You might need an Azure subscription to follow the steps in this repo. 👉 Start your free journey here: https://aka.ms/devrelft 

This Azure Free Trial provides $200 credit for 30 days. Some features may incur costs after the trial. Check the <a href="https://azure.microsoft.com/pricing/calculator/">Azure pricing calculator</a> to estimate costs.

> [!IMPORTANT]
> **Free Tier Limitations:** The Azure free subscription has significant constraints that may prevent full implementation of this repo:
> - **Model access:** Some advanced models (e.g., GPT-5, Claude) may not be available or have very limited quotas
> - **Rate limits:** Strict API call limits (e.g., requests per minute, tokens per day)
> - **Region restrictions:** Free tier resources may only be available in limited regions
> - **Feature restrictions:** Some Microsoft Foundry features (agent orchestration, evaluations) may require pay-as-you-go
> - **Credit exhaustion:** $200 credit can be consumed quickly with heavy AI model usage
>
> **Recommendation:** For full functionality, consider a **pay-as-you-go** subscription or request access to <a href="https://azure.microsoft.com/free/students/">Azure for Students</a> ($100 credit, no credit card required) or the <a href="https://www.microsoft.com/startups">Microsoft for Startups Founders Hub</a>.

## Responsible AI 

Microsoft is committed to helping our customers use our AI products responsibly, sharing our learnings, and building trust-based partnerships through tools like Transparency Notes and Impact Assessments. Many of these resources can be found at [https://aka.ms/RAI](https://aka.ms/RAI).
Microsoft’s approach to responsible AI is grounded in our AI principles of fairness, reliability and safety, privacy and security, inclusiveness, transparency, and accountability.

Large-scale natural language, image, and speech models - like the ones used in this sample - can potentially behave in ways that are unfair, unreliable, or offensive, in turn causing harms. Please consult the [Azure OpenAI service Transparency note](https://learn.microsoft.com/legal/cognitive-services/openai/transparency-note?tabs=text) to be informed about risks and limitations.

The recommended approach to mitigating these risks is to include a safety system in your architecture that can detect and prevent harmful behavior. [Azure AI Content Safety](https://learn.microsoft.com/azure/ai-services/content-safety/overview) provides an independent layer of protection, able to detect harmful user-generated and AI-generated content in applications and services. Azure AI Content Safety includes text and image APIs that allow you to detect material that is harmful. Within Azure AI Foundry portal, the Content Safety service allows you to view, explore and try out sample code for detecting harmful content across different modalities. The following [quickstart documentation](https://learn.microsoft.com/azure/ai-services/content-safety/quickstart-text?tabs=visual-studio%2Clinux&pivots=programming-language-rest) guides you through making requests to the service.

Another aspect to take into account is the overall application performance. With multi-modal and multi-models applications, we consider performance to mean that the system performs as you and your users expect, including not generating harmful outputs. It's important to assess the performance of your overall application using [Performance and Quality and Risk and Safety evaluators](https://learn.microsoft.com/azure/ai-studio/concepts/evaluation-metrics-built-in). You also have the ability to create and evaluate with [custom evaluators](https://learn.microsoft.com/azure/ai-studio/how-to/develop/evaluate-sdk#custom-evaluators).

You can evaluate your AI application in your development environment using the [Azure AI Evaluation SDK](https://microsoft.github.io/promptflow/index.html). Given either a test dataset or a target, your generative AI application generations are quantitatively measured with built-in evaluators or custom evaluators of your choice. To get started with the azure ai evaluation sdk to evaluate your system, you can follow the [quickstart guide](https://learn.microsoft.com/azure/ai-studio/how-to/develop/flow-evaluate-sdk). Once you execute an evaluation run, you can [visualize the results in Azure AI Foundry portal ](https://learn.microsoft.com/azure/ai-studio/how-to/evaluate-flow-results).
