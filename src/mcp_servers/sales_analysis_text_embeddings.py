#!/usr/bin/env python3
"""
Customer Sales Semantic Search Tool

This module provides semantic search functionality for products using Azure OpenAI embeddings.
It generates embeddings for user queries and finds similar products using pgvector cosine similarity.

Usage:
    from customer_sales_semantic_search import SemanticSearchTool

    tool = SemanticSearchTool()
    embedding = tool.generate_query_embedding("waterproof electrical box")

Requirements:
    - Azure OpenAI configured
    - openai package
    - azure-identity package
"""

import logging
import os
from pathlib import Path
from typing import List, Optional

from azure.identity import DefaultAzureCredential, get_bearer_token_provider
from dotenv import load_dotenv
from openai import AzureOpenAI

logger = logging.getLogger(__name__)


class SemanticSearchTextEmbedding:
    """Handles semantic search operations using Azure OpenAI embeddings."""

    def __init__(self) -> None:
        """Initialize the semantic search tool with Azure OpenAI configuration."""
        # Load environment variables
        self._load_environment()

        # Azure OpenAI configuration
        self.endpoint = os.getenv("AZURE_OPENAI_ENDPOINT")
        self.model_name = "text-embedding-3-small"
        self.deployment = os.getenv(
            "EMBEDDING_MODEL_DEPLOYMENT_NAME", "text-embedding-3-small"
        )

        # Check if Azure OpenAI endpoint is configured
        if not self.endpoint or self.endpoint == "<ENDPOINT_URL>":
            logger.warning(
                "Warning: AZURE_OPENAI_ENDPOINT not configured. Semantic search will not work."
            )
            self.openai_client = None
            return

        # Initialize Azure OpenAI client
        try:
            self.openai_client = self._setup_azure_openai_client()
        except Exception as e:
            logger.error("Failed to initialize Azure OpenAI client: %s", e)
            self.openai_client = None

    def _load_environment(self) -> None:
        """Load environment variables from .env files."""
        script_dir = Path(__file__).parent
        # Try to load .env from multiple locations
        env_paths = [
            script_dir.parent / ".env",  # src/.env
            script_dir.parent.parent / ".env",  # workspace root/.env
            Path.cwd() / ".env",  # current working directory/.env
        ]

        for env_path in env_paths:
            if env_path.exists():
                logger.info(f"Loading environment from: {env_path}")
                load_dotenv(env_path, override=True)
                break
        else:
            # Fallback to default behavior
            logger.warning("No .env file found in expected locations")
            load_dotenv()

    def _setup_azure_openai_client(self) -> AzureOpenAI:
        """Setup and return Azure OpenAI client with Entra ID (DefaultAzureCredential) authentication."""
        api_version = "2024-02-01"

        token_provider = get_bearer_token_provider(
            DefaultAzureCredential(),
            "https://cognitiveservices.azure.com/.default",
        )

        return AzureOpenAI(
            api_version=api_version,
            azure_endpoint=self.endpoint,
            azure_ad_token_provider=token_provider,
        )

    def generate_query_embedding(self, query_text: str) -> Optional[List[float]]:
        """
        Generate embedding for the user's query text.

        Args:
            query_text: The user's product description query

        Returns:
            List of float values representing the embedding, or None if failed
        """
        if not self.openai_client:
            logger.error(
                "Azure OpenAI client not initialized. Cannot generate embeddings."
            )
            return None

        try:
            logger.info("Generating embedding for query: '%s'", query_text)

            # Generate embedding using Azure OpenAI
            response = self.openai_client.embeddings.create(
                input=[query_text], model=self.deployment
            )

            # Extract embedding from response
            embedding = response.data[0].embedding
            logger.info("✓ Generated embedding (dimension: %d)", len(embedding))
            return embedding

        except Exception as e:
            logger.error("Error generating embedding: %s", e)
            return None

    def is_available(self) -> bool:
        """Check if the semantic search functionality is available."""
        return self.openai_client is not None
